import 'package:flutter/material.dart';

class TUIToggleThumbSettings {
  /// Creates a toggle thumb style configuration.
  ///
  /// * [size] - thumb size
  /// * [color] - thumb color
  /// * [borderRadius] - thumb border radius
  /// * [gradient] - thumb gradient
  /// * [boxShadow] - thumb box shadow
  /// * [image] - thumb image
  /// * [border] - thumb border
  /// * [shape] - thumb shape
  /// * [customThumb] - custom thumb widget
  const TUIToggleThumbSettings({
    this.size,
    this.color,
    this.borderRadius,
    this.gradient,
    this.boxShadow,
    this.image,
    this.border,
    this.shape = BoxShape.rectangle,
    this.customThumb,
  });

  /// Thumb size
  final double? size;

  /// Thumb color
  final Color? color;

  /// Thumb border radius
  /// This is only used when `shape != BoxShape.circle`
  final double? borderRadius;

  /// Thumb gradient
  final Gradient? gradient;

  /// Thumb box shadow
  final List<BoxShadow>? boxShadow;

  /// Thumb image
  final DecorationImage? image;

  /// Thumb border
  final BoxBorder? border;

  /// Thumb shape
  final BoxShape shape;

  /// Custom thumb widget
  /// If `customThumb != null`, other parameters are not taken into account
  final Widget? customThumb;
}

/// Toggle switch settings
class TUIToggleSwitchSettings {
  /// Creates a toggle switch style configuration.
  ///
  /// * [color] - color of the toggle switch when it's inactive
  /// * [activeColor] - color of the toggle switch when it's active
  /// * [borderRadius] - border radius of the toggle switch
  /// * [border] - border of the toggle switch
  /// * [boxShadow] - box shadow of the toggle switch
  /// * [gradient] - gradient of the toggle switch
  /// * [image] - image of the toggle switch
  /// * [opacity] - opacity of the toggle switch
  TUIToggleSwitchSettings({
    this.borderRadius,
    this.color,
    this.activeColor,
    this.border,
    this.boxShadow,
    this.gradient,
    this.image,
    this.opacity,
  });

  /// Color of the toggle switch when it's inactive
  final Color? color;

  /// Color of the toggle switch when it's active
  final Color? activeColor;

  /// Border radius of the toggle switch.
  /// Default is `size / 2`.
  final double? borderRadius;

  /// Border of the toggle switch.
  final BoxBorder? border;

  /// Box shadow of the toggle switch.
  final List<BoxShadow>? boxShadow;

  /// Gradient of the toggle switch.
  final Gradient? gradient;

  /// Image of the toggle switch.
  final DecorationImage? image;

  /// Opacity of the toggle switch.
  final double? opacity;
}
