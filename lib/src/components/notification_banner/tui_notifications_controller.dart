import 'dart:async';

import 'package:flutter/material.dart';

import 'tui_notification_banner.dart';
import 'tui_notification_types.dart';

/// Shows lightweight notification banners using [Overlay].
///
/// The implementation uses [OverlayEntry] and does not depend on
/// `ScaffoldMessenger`.
///
/// If multiple notifications are requested, [TUINotificationDisplayBehavior]
/// defines what happens.
class TUINotifications {
  TUINotifications._();

  /// Singleton instance.
  static final TUINotifications instance = TUINotifications._();

  /// Pending notification requests.
  final List<TUINotificationRequest> _queue = <TUINotificationRequest>[];

  /// Currently inserted overlay entry.
  OverlayEntry? _activeEntry;

  /// Dismiss callback for the currently shown notification.
  VoidCallback? _activeDismiss;

  /// Completes when the currently shown notification is fully dismissed.
  Future<void>? _activeDone;

  /// Whether a notification is currently visible.
  bool _isShowing = false;

  /// Dismisses the currently shown notification.
  ///
  /// The returned future completes when the notification finishes its exit
  /// animation.
  static Future<void> dismiss() => instance._dismissActive();

  /// Clears the pending notification queue.
  ///
  /// This does not dismiss the currently shown notification.
  static void clearQueue() => instance._queue.clear();

  /// Shows a notification banner.
  ///
  /// The returned future completes when the notification is dismissed.
  ///
  /// You can customize the default banner using `style`.
  ///
  /// If `builder` is provided, it fully overrides the banner UI.
  ///
  /// If `duration` is null or `Duration.zero`, the notification will not
  /// auto-dismiss.
  ///
  /// If `barrierDismissible` is true, tapping outside the banner will dismiss
  /// it.
  ///
  /// If `swipeToDismiss` is true, the banner can be dismissed with a swipe
  /// gesture (up for top, down for bottom).
  ///
  /// You can configure animation using `animationDuration`,
  /// `reverseAnimationDuration` and `curve`.
  ///
  /// Use `margin` to add extra offset from the screen edges.
  static Future<void> show(
    BuildContext context, {
    required String message,
    TUINotificationPosition position = TUINotificationPosition.top,
    TUINotificationDisplayBehavior displayBehavior =
        TUINotificationDisplayBehavior.replace,
    Duration? duration = const Duration(seconds: 2),
    String? actionText,
    VoidCallback? onAction,
    bool showCloseIcon = true,
    bool barrierDismissible = false,
    bool swipeToDismiss = true,
    EdgeInsetsGeometry? margin,
    Duration animationDuration = const Duration(milliseconds: 220),
    Duration reverseAnimationDuration = const Duration(milliseconds: 180),
    Curve curve = Curves.easeOutCubic,
    TUINotificationStyle? style,
    TUINotificationBuilder? builder,
  }) =>
      instance._show(
        Overlay.of(context, rootOverlay: true),
        TUINotificationRequest(
          message: message,
          position: position,
          displayBehavior: displayBehavior,
          duration: duration,
          animationDuration: animationDuration,
          reverseAnimationDuration: reverseAnimationDuration,
          curve: curve,
          actionText: actionText,
          onAction: onAction,
          showCloseIcon: showCloseIcon,
          barrierDismissible: barrierDismissible,
          swipeToDismiss: swipeToDismiss,
          margin: margin,
          style: style,
          builder: builder,
        ),
      );

  /// Internal entry point that applies [TUINotificationDisplayBehavior].
  Future<void> _show(
    OverlayState overlay,
    TUINotificationRequest request,
  ) async {
    if (_isShowing) {
      switch (request.displayBehavior) {
        case TUINotificationDisplayBehavior.ignoreIfVisible:
          return;
        case TUINotificationDisplayBehavior.replace:
          _queue.clear();
          await _dismissActive();
          break;
        case TUINotificationDisplayBehavior.queue:
          _queue.add(request);
          return;
      }
    }

    await _present(overlay, request);

    while (_queue.isNotEmpty) {
      final next = _queue.removeAt(0);
      await _present(overlay, next);
    }
  }

  /// Dismisses the currently shown notification (if any).
  ///
  /// The returned future completes when the notification finishes its exit
  /// animation and is removed.
  Future<void> _dismissActive() async {
    final dismiss = _activeDismiss;
    final done = _activeDone;
    dismiss?.call();

    if (done != null) {
      await done;
    }
  }

  /// Presents a single notification request on the given [overlay].
  Future<void> _present(
    OverlayState overlay,
    TUINotificationRequest request,
  ) async {
    _isShowing = true;

    final completer = Completer<void>();
    late VoidCallback dismiss;

    _activeDone = completer.future;

    final entry = OverlayEntry(
      builder: (overlayContext) => _TUINotificationOverlay(
        request: request,
        onDismissed: () {
          if (!completer.isCompleted) completer.complete();
        },
        registerDismiss: (cb) => dismiss = cb,
      ),
    );

    _activeEntry = entry;
    _activeDismiss = () {
      dismiss();
    };

    overlay.insert(entry);
    await completer.future;

    _activeEntry?.remove();
    _activeEntry = null;
    _activeDismiss = null;
    _activeDone = null;
    _isShowing = false;
  }
}

/// Overlay widget responsible for positioning, animation, and auto-dismiss.
class _TUINotificationOverlay extends StatefulWidget {
  const _TUINotificationOverlay({
    required this.request,
    required this.onDismissed,
    required this.registerDismiss,
  });

  /// Request to display.
  final TUINotificationRequest request;

  /// Called after the overlay has been dismissed.
  final VoidCallback onDismissed;

  /// Registers an external dismiss callback.
  final ValueChanged<VoidCallback> registerDismiss;

  @override
  State<_TUINotificationOverlay> createState() =>
      _TUINotificationOverlayState();
}

class _TUINotificationOverlayState extends State<_TUINotificationOverlay>
    with SingleTickerProviderStateMixin {
  /// State holder for `_TUINotificationOverlay`.
  ///
  /// Responsible for:
  ///
  /// - Creating and driving the animations.
  /// - Handling auto-dismiss timer.
  /// - Handling user dismissal (close button, swipe, barrier tap).
  /// Animation controller for fade + slide transitions.
  late final AnimationController _controller;

  /// Fade animation.
  late final Animation<double> _fade;

  /// Slide animation.
  late final Animation<Offset> _slide;

  /// Auto-dismiss timer.
  Timer? _timer;

  /// Whether the overlay has already been dismissed.
  bool _dismissed = false;

  @override

  /// Initializes animations and schedules auto-dismiss if configured.
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.request.animationDuration,
      reverseDuration: widget.request.reverseAnimationDuration,
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    final begin = widget.request.position == TUINotificationPosition.top
        ? const Offset(0, -0.15)
        : const Offset(0, 0.15);

    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: widget.request.curve),
    );

    widget.registerDismiss(_dismiss);

    unawaited(_controller.forward());
    final duration = widget.request.duration;
    if (duration != null && duration > Duration.zero) {
      _timer = Timer(duration, () => unawaited(_dismiss()));
    }
  }

  @override

  /// Cleans up the timer and animation controller.
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// Dismisses the overlay (idempotent).
  Future<void> _dismiss() async {
    if (_dismissed) return;
    _dismissed = true;

    _timer?.cancel();

    if (mounted) {
      await _controller.reverse();
    }

    widget.onDismissed();
  }

  @override

  /// Builds and positions the overlay banner widget.
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final safeAreaPadding =
        widget.request.position == TUINotificationPosition.top
            ? EdgeInsets.only(
                top: mediaQuery.padding.top,
              )
            : EdgeInsets.only(
                bottom: mediaQuery.padding.bottom,
              );

    final baseMargin = widget.request.position == TUINotificationPosition.top
        ? const EdgeInsets.only(top: 12, left: 12, right: 12)
        : const EdgeInsets.only(bottom: 12, left: 12, right: 12);

    final extraMargin =
        widget.request.margin?.resolve(Directionality.of(context));

    final padding = extraMargin == null
        ? safeAreaPadding + baseMargin
        : safeAreaPadding + baseMargin + extraMargin;

    final alignment = widget.request.position == TUINotificationPosition.top
        ? Alignment.topCenter
        : Alignment.bottomCenter;

    var child = widget.request.builder?.call(context, _dismiss) ??
        TUINotificationBanner(
          message: widget.request.message,
          actionText: widget.request.actionText,
          onAction: () {
            widget.request.onAction?.call();
            unawaited(_dismiss());
          },
          showCloseIcon: widget.request.showCloseIcon,
          onClose: _dismiss,
          style: widget.request.style,
        );

    child = FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: child,
      ),
    );

    if (widget.request.swipeToDismiss) {
      final dismissDirection =
          widget.request.position == TUINotificationPosition.top
              ? DismissDirection.up
              : DismissDirection.down;

      child = Dismissible(
        key: const ValueKey<String>('tui_notification_banner'),
        direction: dismissDirection,
        onDismissed: (_) => unawaited(_dismiss()),
        child: child,
      );
    }

    return Stack(
      children: [
        if (widget.request.barrierDismissible)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => unawaited(_dismiss()),
            ),
          ),
        Align(
          alignment: alignment,
          child: SafeArea(
            top: widget.request.position == TUINotificationPosition.top,
            bottom: widget.request.position == TUINotificationPosition.bottom,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
