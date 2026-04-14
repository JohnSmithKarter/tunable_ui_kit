import 'package:flutter/material.dart';

//*--------------------------- DropdownDecoration ---------------------------*//

/// Dropdown widget style.
///
/// Allows customizing the appearance of the dropdown widget.
class TUICustomDropdownDecoration {
  /// Creates a dropdown style configuration.
  ///
  /// * [elementSeparator] - separator between list items
  /// * [titleStyle] - dropdown title text style
  /// * [selectedItemTextStyle] - selected item text style
  /// * [titleOverflow] - dropdown title overflow
  /// * [titleMaxLines] - max lines for the title
  /// * [titleTextAlign] - title alignment
  /// * [height] - dropdown height
  /// * [width] - dropdown width
  /// * [decoration] - dropdown container decoration
  /// * [rippleRadius] - ripple border radius
  /// * [enableRipple] - enable/disable ripple effect
  /// * [padding] - container inner padding
  /// * [expandIcon] - expand indicator icon
  const TUICustomDropdownDecoration({
    this.elementSeparator,
    this.titleStyle,
    this.selectedItemTextStyle,
    this.titleOverflow,
    this.titleMaxLines,
    this.titleTextAlign,
    this.height,
    this.width,
    this.decoration,
    this.rippleRadius,
    this.enableRipple = true,
    this.padding,
    this.expandIcon,
  });

  /// Dropdown title text style.
  final TextStyle? titleStyle;

  /// Selected item text style.
  final TextStyle? selectedItemTextStyle;

  /// Dropdown title overflow.
  final TextOverflow? titleOverflow;

  /// Max lines for the dropdown title.
  final int? titleMaxLines;

  /// Dropdown title alignment.
  final TextAlign? titleTextAlign;

  /// Dropdown height.
  final double? height;

  /// Dropdown width.
  final double? width;

  /// Separator between items.
  final Widget? elementSeparator;

  /// Dropdown container decoration.
  final Decoration? decoration;

  /// Ripple border radius.
  final BorderRadius? rippleRadius;

  /// Whether the ripple effect is enabled.
  final bool enableRipple;

  /// Inner padding.
  final EdgeInsetsGeometry? padding;

  /// Expand indicator icon.
  final Widget? expandIcon;
}

//*------------------------- DropdownMenuDecoration -------------------------*//

/// Dropdown menu style.
///
/// Allows customizing the appearance of the dropdown menu.
class TUICustomDropdownMenuDecoration {
  /// Creates a dropdown menu style configuration.
  ///
  /// * [borderRadius] - menu border radius
  /// * [itemColor] - menu item color
  /// * [menuColor] - menu container color
  /// * [menuShadow] - menu container shadow
  /// * [border] - menu container border
  /// * [gradient] - menu container gradient
  /// * [constraints] - menu container constraints
  /// * [scrollbarSettings] - scrollbar settings
  const TUICustomDropdownMenuDecoration({
    this.borderRadius,
    this.itemColor,
    this.menuColor,
    this.menuShadow,
    this.border,
    this.gradient,
    this.constraints,
    this.scrollbarSettings,
  });

  /// Menu border radius.
  final BorderRadiusGeometry? borderRadius;

  /// Menu item color.
  final Color? itemColor;

  /// Menu container color.
  final Color? menuColor;

  /// Menu container shadow.
  final List<BoxShadow>? menuShadow;

  /// Menu container border.
  final BoxBorder? border;

  /// Menu container gradient.
  final Gradient? gradient;

  /// Menu container constraints.
  final BoxConstraints? constraints;

  /// Scrollbar settings.
  final TUIScrollbarSettings? scrollbarSettings;
}

//*-------------------------- ScrollbarSettings -----------------------------*//

/// Scrollbar settings.
class TUIScrollbarSettings {
  /// Creates a scrollbar settings configuration.
  ///
  /// * [thumbVisibility] - thumb visibility
  /// * [trackVisibility] - track visibility
  /// * [thickness] - thickness
  /// * [radius] - radius
  /// * [interactive] - interactive
  /// * [scrollbarOrientation] - orientation
  const TUIScrollbarSettings({
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.interactive,
    this.scrollbarOrientation,
  });

  /// Thumb visibility.
  final bool? thumbVisibility;

  /// Track visibility.
  final bool? trackVisibility;

  /// Thickness.
  final double? thickness;

  /// Radius.
  final Radius? radius;

  /// Interactive.
  final bool? interactive;

  /// Orientation.
  final ScrollbarOrientation? scrollbarOrientation;
}

//*------------------------- DropdownItemDecoration -------------------------*//

/// Dropdown menu item style.
class TUICustomDropdownItemDecoration {
  /// Creates styles for dropdown menu items.
  ///
  /// * [titleStyle] - item title text style
  /// * [titleOverflow] - item title overflow
  /// * [titleMaxLines] - max lines for item title
  /// * [titleTextAlign] - item title alignment
  /// * [padding] - inner padding
  /// * [margin] - outer margin
  /// * [decoration] - item decoration
  /// * [enableRipple] - enable/disable ripple effect
  TUICustomDropdownItemDecoration({
    this.titleStyle,
    this.titleOverflow,
    this.titleMaxLines,
    this.titleTextAlign,
    this.padding,
    this.margin,
    this.decoration,
    this.enableRipple = true,
  });

  /// Item title text style.
  final TextStyle? titleStyle;

  /// Item title overflow.
  final TextOverflow? titleOverflow;

  /// Max lines for item title.
  final int? titleMaxLines;

  /// Item title alignment.
  final TextAlign? titleTextAlign;

  /// Inner padding.
  final EdgeInsetsGeometry? padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Item decoration.
  final Decoration? decoration;

  /// Whether the ripple effect is enabled.
  final bool enableRipple;
}
