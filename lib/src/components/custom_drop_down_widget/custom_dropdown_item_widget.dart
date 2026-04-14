import 'package:flutter/material.dart';

import '../../../tunable_ui_kit.dart';

/// Dropdown menu item widget.
class TUICustomDropdownItemWidget extends StatelessWidget {
  const TUICustomDropdownItemWidget({
    required this.title,
    required this.onTap,
    this.decoration,
    super.key,
  });

  /// Item title.
  final String title;

  /// Callback invoked on tap.
  final VoidCallback onTap;

  /// Item style.
  final TUICustomDropdownItemDecoration? decoration;

  /// Whether to enable ripple effect.
  bool get _enableRipple => decoration?.enableRipple ?? true;

  /// Item title text style.
  TextStyle get _titleStyle =>
      decoration?.titleStyle ??
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  /// Inner padding.
  EdgeInsetsGeometry get _padding =>
      decoration?.padding ??
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      );

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: _enableRipple
            ? InkWell(
                onTap: onTap,
                child: _buildContent(),
              )
            : GestureDetector(
                onTap: onTap,
                child: _buildContent(),
              ),
      );

  Widget _buildContent() => Container(
        decoration: decoration?.decoration,
        margin: decoration?.margin,
        width: double.infinity,
        padding: _padding,
        child: Text(
          title,
          style: _titleStyle,
          overflow: decoration?.titleOverflow,
          maxLines: decoration?.titleMaxLines,
          textAlign: decoration?.titleTextAlign,
        ),
      );
}
