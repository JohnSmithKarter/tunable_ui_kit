import 'package:flutter/material.dart';

/// Defines where the notification banner is shown.
enum TUINotificationPosition {
  top,
  bottom,
}

/// Builder that allows you to fully override notification banner UI.
///
/// The [dismiss] callback should be called to close the currently shown
/// notification.
typedef TUINotificationBuilder = Widget Function(
  BuildContext context,
  VoidCallback dismiss,
);

/// Style configuration for the default `TUINotificationBanner`.
///
/// If a field is not provided, the default widget values are used.
class TUINotificationStyle {
  const TUINotificationStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.borderRadius,
    this.boxShadow,
    this.constraints,
    this.padding,
    this.messageTextStyle,
    this.maxLines,
    this.overflow,
    this.actionTextStyle,
    this.actionButtonStyle,
    this.closeIcon,
    this.closeIconColor,
  });

  /// Background color of the banner.
  final Color? backgroundColor;

  /// Foreground color used for text and icons.
  final Color? foregroundColor;

  /// Optional leading icon.
  final IconData? icon;

  /// Overrides icon color.
  final Color? iconColor;

  /// Overrides icon size.
  final double? iconSize;

  /// Border radius of the banner container.
  final BorderRadius? borderRadius;

  /// Shadow list for the banner container.
  final List<BoxShadow>? boxShadow;

  /// Layout constraints for the banner.
  final BoxConstraints? constraints;

  /// Inner padding of the banner.
  final EdgeInsetsGeometry? padding;

  /// Text style for the message.
  final TextStyle? messageTextStyle;

  /// Max number of lines for the message.
  final int? maxLines;

  /// Overflow behavior for the message.
  final TextOverflow? overflow;

  /// Text style for the action label.
  final TextStyle? actionTextStyle;

  /// Button style for the action button.
  final ButtonStyle? actionButtonStyle;

  /// Close icon.
  final IconData? closeIcon;

  /// Overrides close icon color.
  final Color? closeIconColor;
}

/// Defines how multiple notifications are handled.
enum TUINotificationDisplayBehavior {
  /// Immediately dismisses the current notification and shows the new one.
  replace,

  /// Displays notifications one-by-one.
  queue,

  /// If a notification is visible, ignores new requests.
  ignoreIfVisible,
}

/// Internal request model used by `TUINotifications`.
///
/// The request is created in `TUINotifications.show()` and then queued or
/// presented immediately depending on [displayBehavior].
class TUINotificationRequest {
  const TUINotificationRequest({
    required this.message,
    required this.position,
    required this.displayBehavior,
    required this.duration,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.curve,
    required this.actionText,
    required this.onAction,
    required this.showCloseIcon,
    required this.barrierDismissible,
    required this.swipeToDismiss,
    required this.margin,
    required this.style,
    required this.builder,
  });

  /// Message text.
  final String message;

  /// Where to place the banner on screen.
  final TUINotificationPosition position;

  /// How to handle multiple notification requests.
  final TUINotificationDisplayBehavior displayBehavior;

  /// Auto-dismiss duration.
  ///
  /// If null, the notification will stay visible until dismissed manually.
  final Duration? duration;

  /// Entrance animation duration.
  final Duration animationDuration;

  /// Exit animation duration.
  final Duration reverseAnimationDuration;

  /// Animation curve used for the slide transition.
  final Curve curve;

  /// Optional action label.
  final String? actionText;

  /// Optional action callback.
  final VoidCallback? onAction;

  /// Whether to show the close icon.
  final bool showCloseIcon;

  /// Whether tapping outside the banner should dismiss it.
  final bool barrierDismissible;

  /// Whether swipe gesture should dismiss the banner.
  final bool swipeToDismiss;

  /// External margin around the banner.
  ///
  /// This value is added on top of the safe area insets and base padding.
  final EdgeInsetsGeometry? margin;

  /// Style configuration for the default banner.
  ///
  /// Applied only when [builder] is null.
  final TUINotificationStyle? style;

  /// Full UI override.
  ///
  /// When provided, the default banner and its style configuration are not
  /// used.
  final TUINotificationBuilder? builder;
}
