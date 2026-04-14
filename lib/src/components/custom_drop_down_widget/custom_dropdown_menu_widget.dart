import 'package:flutter/material.dart';

import '../../../tunable_ui_kit.dart';
import '../../theme/colors.dart';

/// Custom dropdown menu widget.
class TUICustomDropdownMenuWidget extends StatefulWidget {
  const TUICustomDropdownMenuWidget({
    required this.animation,
    required this.items,
    this.decoration,
    super.key,
  });

  /// Expand/collapse animation.
  final Animation<double> animation;

  /// Menu items.
  final List<Widget> items;

  /// Menu style.
  final TUICustomDropdownMenuDecoration? decoration;

  @override
  State<TUICustomDropdownMenuWidget> createState() =>
      _TUICustomDropdownMenuWidgetState();
}

class _TUICustomDropdownMenuWidgetState
    extends State<TUICustomDropdownMenuWidget> {
  /// Scroll controller.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Menu border radius.
  BorderRadiusGeometry get _borderRadius =>
      widget.decoration?.borderRadius ?? BorderRadius.circular(16);

  /// Menu container color.
  Color get _menuColor => widget.decoration?.menuColor ?? Colors.white;

  /// Menu container shadow.
  List<BoxShadow> get _menuShadow =>
      widget.decoration?.menuShadow ??
      [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.16),
          blurRadius: 24,
          offset: const Offset(0, 8),
          spreadRadius: 1,
        ),
      ];

  /// Menu container border.
  BoxBorder get _border =>
      widget.decoration?.border ?? Border.all(color: TUIColors.primary);

  /// Menu container constraints.
  BoxConstraints get _constraints =>
      widget.decoration?.constraints ??
      BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 2,
      );

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: widget.animation,
          builder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(
              color: _menuColor,
              borderRadius: _borderRadius,
              boxShadow: _menuShadow,
              border: _border,
            ),
            child: ClipRRect(
              borderRadius: _borderRadius,
              child: Align(
                heightFactor: widget.animation.value,
                child: Opacity(opacity: widget.animation.value, child: child),
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.decoration?.itemColor,
              borderRadius: _borderRadius,
              gradient: widget.decoration?.gradient,
            ),
            constraints: _constraints,
            child: Scrollbar(
              controller: _scrollController,
              radius: widget.decoration?.scrollbarSettings?.radius ??
                  const Radius.circular(4),
              thumbVisibility:
                  widget.decoration?.scrollbarSettings?.thumbVisibility ?? true,
              trackVisibility:
                  widget.decoration?.scrollbarSettings?.trackVisibility,
              thickness: widget.decoration?.scrollbarSettings?.thickness,
              interactive: widget.decoration?.scrollbarSettings?.interactive,
              scrollbarOrientation:
                  widget.decoration?.scrollbarSettings?.scrollbarOrientation,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items,
                ),
              ),
            ),
          ),
        ),
      );
}
