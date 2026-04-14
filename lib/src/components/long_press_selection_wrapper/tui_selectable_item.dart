import 'package:flutter/material.dart';

/// Side where the selection control is placed.
enum TUIControlSide {
  start,
  end,
}

/// A widget that, on long press, shifts its child and shows a selection control.
class TUISelectableItem extends StatelessWidget {
  const TUISelectableItem({
    required this.onSelectionModeChanged,
    required this.selectionMode,
    required this.select,
    required this.isSelected,
    required this.child,
    this.enabled = true,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 200),
    this.selectionColor,
    this.offset,
    this.selectedWidget,
    this.unselectedWidget,
    this.padding,
    this.controlSide = TUIControlSide.start,
    this.enableRipple = false,
    this.rippleBorderRadius,
    super.key,
  });

  /// Child widget.
  final Widget child;

  /// Callback invoked on long press to request a selection mode change.
  /// Receives the next selection mode value (`!selectionMode`).
  final ValueChanged<bool> onSelectionModeChanged;

  /// Whether selection mode is active.
  final bool selectionMode;

  /// Callback for selecting the item (usually toggles selected/unselected state).
  final VoidCallback select;

  /// Whether selection functionality is enabled
  /// (if false, selection by long press is disabled).
  final bool enabled;

  /// Callback for a normal tap when [selectionMode] is false.
  final VoidCallback? onTap;

  /// Whether the item is selected.
  final bool isSelected;

  /// Duration of the shift/switch animations.
  final Duration animationDuration;

  /// Selection control color (optional).
  final Color? selectionColor;

  /// Shift offset for the content.
  final Offset? offset;

  /// Widget displayed for the selected state.
  final Widget? selectedWidget;

  /// Widget displayed for the unselected state.
  final Widget? unselectedWidget;

  /// Padding around [child].
  final EdgeInsetsGeometry? padding;

  /// Side where the selection control is shown.
  final TUIControlSide controlSide;

  /// Whether Material ripple is enabled.
  final bool enableRipple;

  /// Border radius used for Material ripple clipping.
  final BorderRadius? rippleBorderRadius;

  /// Resolved shift offset.
  Offset get _offset => offset ?? const Offset(40, 0);

  /// Resolved selected widget.
  Widget get _selectedWidget => selectedWidget ?? const Icon(Icons.check_box);

  /// Resolved unselected widget.
  Widget get _unselectedWidget =>
      unselectedWidget ?? const Icon(Icons.check_box_outline_blank);

  /// Extra padding offset for the selection control (when [padding] is set).
  double get _checkboxPaddingOffset {
    if (padding != null) {
      if (padding?.horizontal != 0) {
        return padding!.horizontal / 2;
      }
    }
    return 0;
  }

  /// Returns the onTap callback depending on selection mode.
  VoidCallback? get _onTap {
    if (selectionMode) {
      return enabled ? select : (onTap ?? select);
    }
    return onTap ?? select;
  }

  /// Returns the onLongPress callback depending on [enabled].
  VoidCallback? get _onLongPress {
    if (!enabled) return null;
    return () => onSelectionModeChanged(!selectionMode);
  }

  IconThemeData? get _selectionIconTheme {
    final color = selectionColor;
    if (color == null) return null;
    return IconThemeData(color: color);
  }

  @override
  Widget build(BuildContext context) {
    final br = rippleBorderRadius ?? BorderRadius.zero;

    final content = IconTheme(
      data: _selectionIconTheme ?? const IconThemeData(),
      child: IntrinsicHeight(
        child: OverflowBox(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width + _offset.dx,
          alignment: controlSide == TUIControlSide.start
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: animationDuration,
            transform: Matrix4.translationValues(
              selectionMode
                  ? (controlSide == TUIControlSide.start
                      ? _offset.dx
                      : -_offset.dx)
                  : 0,
              selectionMode ? _offset.dy : 0,
              0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controlSide == TUIControlSide.start)
                  _CheckBox(
                    width: _offset.dx,
                    padding: EdgeInsets.only(left: _checkboxPaddingOffset),
                    animationDuration: animationDuration,
                    child: isSelected ? _selectedWidget : _unselectedWidget,
                  ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: child,
                  ),
                ),
                if (controlSide == TUIControlSide.end)
                  _CheckBox(
                    width: _offset.dx,
                    padding: EdgeInsets.only(right: _checkboxPaddingOffset),
                    animationDuration: animationDuration,
                    child: isSelected ? _selectedWidget : _unselectedWidget,
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    if (!enableRipple) {
      return GestureDetector(
        onLongPress: _onLongPress,
        onTap: _onTap,
        child: content,
      );
    }

    return Material(
      color: Colors.transparent,
      borderRadius: br,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: br,
        onLongPress: _onLongPress,
        onTap: _onTap,
        child: content,
      ),
    );
  }
}

/// Internal widget for the selection control.
class _CheckBox extends StatelessWidget {
  const _CheckBox({
    required this.width,
    required this.padding,
    required this.animationDuration,
    required this.child,
  });

  /// Control width.
  final double width;

  /// Control padding.
  final EdgeInsetsGeometry padding;

  /// Animation duration.
  final Duration animationDuration;

  /// Control child.
  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: Center(
          child: Padding(
            padding: padding,
            child: AnimatedSwitcher(
              duration: animationDuration,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
              child: child,
            ),
          ),
        ),
      );
}
