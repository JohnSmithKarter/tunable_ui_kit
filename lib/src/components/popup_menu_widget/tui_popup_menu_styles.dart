import 'package:flutter/material.dart';

/// Popup widget style.
///
/// Allows customizing the appearance of the popup widget.
class TUIPopupDecoration {
  /// Creates a popup style configuration.
  ///
  /// * [padding] - container inner padding
  /// * [borderRadius] - container border radius
  /// * [elevation] - shadow elevation
  /// * [splashRadius] - tap ripple radius
  /// * [shadowColor] - shadow color
  /// * [width] - width
  /// * [height] - height
  /// * [alignment] - alignment
  /// * [decoration] - container decoration
  /// * [gapWidget] - widget used to separate elements
  /// * [textStyle] - text style
  /// * [icon] - icon
  /// * [surfaceTintColor] - surface tint color (Material 3)
  const TUIPopupDecoration({
    this.padding,
    this.borderRadius,
    this.elevation,
    this.splashRadius,
    this.shadowColor,
    this.width,
    this.height,
    this.alignment,
    this.decoration,
    this.gapWidget,
    this.textStyle,
    this.icon,
    this.surfaceTintColor,
  });

  /// Padding.
  final EdgeInsetsGeometry? padding;

  /// Border radius.
  final BorderRadius? borderRadius;

  /// Shadow elevation.
  final double? elevation;

  /// Tap ripple radius.
  final double? splashRadius;

  /// Shadow color.
  final Color? shadowColor;

  /// Width.
  final double? width;

  /// Height.
  final double? height;

  /// Alignment.
  final AlignmentGeometry? alignment;

  /// Container decoration.
  final Decoration? decoration;

  /// Widget used to separate elements.
  final Widget? gapWidget;

  /// Text style.
  final TextStyle? textStyle;

  /// Icon.
  final Widget? icon;

  /// Surface tint color (Material 3).
  final Color? surfaceTintColor;
}

/// Popup menu widget style.
class TUIPopupMenuDecoration {
  /// Creates a popup menu style configuration.
  ///
  /// * [offset] - offset
  /// * [color] - background color
  /// * [constraints] - constraints
  /// * [animationStyle] - popup open animation style
  /// * [dividerWidget] - widget used to separate elements
  /// * [animationDuration] - animation duration
  const TUIPopupMenuDecoration({
    this.offset,
    this.color,
    this.constraints,
    this.animationStyle,
    this.dividerWidget,
    this.animationDuration,
  });

  /// Offset.
  final Offset? offset;

  /// Background color.
  final Color? color;

  /// Constraints.
  final BoxConstraints? constraints;

  /// Popup open animation style.
  final AnimationStyle? animationStyle;

  /// Widget used to separate elements.
  final Widget? dividerWidget;

  /// Animation duration.
  final Duration? animationDuration;
}

/// Popup menu item style.
class TUIPopupElementDecoration {
  /// Creates a popup menu item style configuration.
  ///
  /// * [height] - item height
  /// * [unselectedTextStyle] - unselected item text style
  /// * [selectedTextStyle] - selected item text style
  /// * [selectIcon] - selected item icon
  /// * [rippleBorderRadius] - tap ripple border radius
  /// * [enableRipple] - enable/disable ripple effect
  /// * [splashColor] - splash color for ripple effect
  /// * [padding] - padding
  /// * [decoration] - selected item decoration
  const TUIPopupElementDecoration({
    this.height,
    this.unselectedTextStyle,
    this.selectedTextStyle,
    this.selectIcon,
    this.rippleBorderRadius,
    this.enableRipple = true,
    this.splashColor,
    this.padding,
    this.decoration,
  });

  /// Item height.
  final double? height;

  /// Unselected item text style.
  final TextStyle? unselectedTextStyle;

  /// Selected item text style.
  final TextStyle? selectedTextStyle;

  /// Selected item icon.
  final Widget? selectIcon;

  /// Tap ripple border radius.
  final BorderRadius? rippleBorderRadius;

  /// Whether the ripple effect is enabled.
  final bool enableRipple;

  /// Splash color for ripple effect.
  final Color? splashColor;

  /// Padding.
  final EdgeInsetsGeometry? padding;

  /// Selected item decoration.
  final Decoration? decoration;
}
