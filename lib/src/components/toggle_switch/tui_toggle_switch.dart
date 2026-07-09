import 'dart:async';

import 'package:flutter/material.dart';

import '../../../tunable_ui_kit.dart';

//! Реализовать:
//! - Параметр для изменения цвета thumb при выключенном состоянии
//! - градиент для background и thumb
//! - возможность вставлять картинку в свич

/// Toggle switch widget.
class TUIToggleSwitch extends StatefulWidget {
  const TUIToggleSwitch({
    required this.size,
    this.aspectRatio,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.thumbSettings,
    this.initialValue = false,
    this.margin,
    this.settings,
    this.onChanged,
    this.enabled = true,
    this.onBeforeToggle,
    super.key,
  });

  /// Size of the toggle switch.
  final double size;

  /// Aspect ratio of the toggle switch.
  /// Default is `1.5`.
  final double? aspectRatio;

  /// Duration of the animation.
  /// Default is `300ms`.
  final Duration duration;

  /// Curve of the animation.
  /// Default is `Curves.easeInOut`.
  final Curve curve;

  /// Settings for the thumb.
  final TUIToggleThumbSettings? thumbSettings;

  /// Initial value of the toggle switch.
  /// Default is `false`.
  final bool initialValue;

  /// Margin of the toggle switch.
  final EdgeInsetsGeometry? margin;

  /// Settings for the toggle switch.
  final TUIToggleSwitchSettings? settings;

  /// Callback when toggle value changes
  final ValueChanged<bool>? onChanged;

  /// Whether the toggle switch is enabled
  final bool enabled;

  /// Callback before toggle value changes
  /// Return false to prevent toggle
  final Future<bool> Function(bool newValue)? onBeforeToggle;

  @override
  State<TUIToggleSwitch> createState() => _TUIToggleSwitchState();
}

class _TUIToggleSwitchState extends State<TUIToggleSwitch>
    with SingleTickerProviderStateMixin {
  /// Settings for the toggle switch.
  TUIToggleSwitchSettings? get settings => widget.settings;

  /// Aspect ratio of the toggle switch.
  /// Default is 1.5.
  double get aspectRatio {
    if (widget.aspectRatio == null) return 1.5;
    if (widget.aspectRatio! < 1.5) return 1.5;
    return widget.aspectRatio!;
  }

  /// Width of the toggle switch.
  double get width => widget.size * aspectRatio;

  /// Height of the toggle switch.
  double get height => widget.size;

  /// Animation controller for the toggle switch.
  late AnimationController _animationController;

  /// Animation for the toggle switch.
  late Animation<double> _animation;

  /// Border radius of the toggle switch.
  /// Default is `size / 2`.
  double get borderRadius {
    if (settings?.borderRadius == null) return widget.size / 2;
    return settings!.borderRadius!;
  }

  /// Current value of the toggle switch.
  bool _value = false;

  /// Color of the toggle switch.
  Color get color => _value
      ? settings?.activeColor ?? Colors.green[200]!
      : settings?.color ?? Colors.green[200]!;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _animationController =
        AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: widget.curve),
    );

    // If initialValue is true, immediately set the animation to the end state
    if (widget.initialValue) {
      unawaited(_animationController.forward(from: 1.0));
    }
  }

  /// Toggle the toggle switch.
  Future<void> _toggle() async {
    if (!widget.enabled) return;

    final newValue = !_value;

    if (widget.onBeforeToggle != null) {
      final shouldToggle = await widget.onBeforeToggle!(newValue);
      if (!shouldToggle) return;
    }

    setState(() => _value = newValue);

    if (_value) {
      await _animationController.forward();
    } else {
      await _animationController.reverse();
    }

    widget.onChanged?.call(_value);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _toggle,
        child: Opacity(
          opacity: widget.settings?.opacity ?? (widget.enabled ? 1.0 : 0.5),
          child: AnimatedContainer(
            duration: widget.duration,
            margin: widget.margin,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius),
              border: widget.settings?.border,
              boxShadow: widget.settings?.boxShadow,
              gradient: widget.settings?.gradient,
              image: widget.settings?.image,
            ),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    // Calculate thumb position with padding
                    final thumbSize = widget.thumbSettings?.size ?? widget.size;
                    final leftPadding = (widget.size - thumbSize) / 2;
                    final maxOffset = (widget.size * aspectRatio) -
                        thumbSize -
                        leftPadding * 2;
                    final offset = maxOffset * _animation.value + leftPadding;

                    return Positioned(
                      left: offset,
                      top: (widget.size - thumbSize) / 2,
                      child: _DefaultThumbWidget(
                        swithSize: widget.size,
                        thumbSettings: widget.thumbSettings,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

/// Default thumb widget for the toggle switch.
class _DefaultThumbWidget extends StatelessWidget {
  const _DefaultThumbWidget({required this.swithSize, this.thumbSettings});

  /// Thumb settings
  final TUIToggleThumbSettings? thumbSettings;

  /// Switch size
  final double swithSize;

  /// Thumb size
  double get _thumbSize => thumbSettings?.size ?? swithSize;

  /// Thumb color
  Color get _thumbColor => thumbSettings?.color ?? Colors.green;

  /// Thumb border radius
  double get _thumbBorderRadius =>
      thumbSettings?.borderRadius ?? _thumbSize / 2;

  @override
  Widget build(BuildContext context) =>
      thumbSettings?.customThumb ??
      Container(
        width: _thumbSize,
        height: _thumbSize,
        decoration: BoxDecoration(
          color: _thumbColor,
          borderRadius: thumbSettings?.shape == BoxShape.circle
              ? null
              : BorderRadius.circular(_thumbBorderRadius),
          gradient: thumbSettings?.gradient,
          boxShadow: thumbSettings?.boxShadow,
          image: thumbSettings?.image,
          border: thumbSettings?.border,
          shape: thumbSettings?.shape ?? BoxShape.rectangle,
        ),
      );
}
