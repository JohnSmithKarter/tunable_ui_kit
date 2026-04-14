import 'package:flutter/material.dart';

import 'tui_popup_menu_styles.dart';

/// A widget that shows a popup menu for selecting an item.
///
/// [T] is the item type.
class TUIPopupMenuWidget<T> extends StatefulWidget {
  const TUIPopupMenuWidget({
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.initialValue,
    super.key,
    this.itemToString,
    this.popupDecoration,
    this.enabled = true,
    this.popupMenuDecoration,
    this.popupElementDecoration,
  });

  /// Items list.
  final List<T> items;

  /// Currently selected item.
  final T selectedItem;

  /// Initial value.
  final T? initialValue;

  /// Callback invoked when an item is selected.
  final Function(T) onSelected;

  /// Function used to format an item into a string.
  ///
  /// If not provided, the default `toString()` is used for [T].
  final String Function(T value)? itemToString;

  /// Whether the widget is enabled.
  final bool enabled;

  /// Popup widget style.
  final TUIPopupDecoration? popupDecoration;

  /// Popup menu style.
  final TUIPopupMenuDecoration? popupMenuDecoration;

  /// Popup menu item style.
  final TUIPopupElementDecoration? popupElementDecoration;

  @override
  State<TUIPopupMenuWidget<T>> createState() => _TUIPopupMenuWidgetState<T>();
}

class _TUIPopupMenuWidgetState<T> extends State<TUIPopupMenuWidget<T>>
    with TickerProviderStateMixin {
  /// Animation controller.
  late final AnimationController _controller;

  /// Animation duration.
  Duration get animationDuration =>
      widget.popupMenuDecoration?.animationDuration ??
      const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Item height.
  double get itemHeight =>
      widget.popupElementDecoration?.height ?? kMinInteractiveDimension;

  /// Unselected item text style.
  TextStyle get unselectedItemTextStyle =>
      widget.popupElementDecoration?.unselectedTextStyle ??
      const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  /// Selected item text style.
  TextStyle get selectedItemTextStyle =>
      widget.popupElementDecoration?.selectedTextStyle ??
      const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  /// Selected item icon.
  Widget? get selectIcon => widget.popupElementDecoration?.selectIcon;

  /// Builds a menu item.
  _RoundedPopupMenuItem<T> _buildMenuItem(
    BuildContext context,
    T value,
    T selectedValue,
  ) {
    final isSelected = selectedValue == value;
    return _RoundedPopupMenuItem(
      value: value,
      itemHeight: itemHeight,
      popupElementDecoration: widget.popupElementDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.itemToString?.call(value) ?? value.toString(),
            style: isSelected ? selectedItemTextStyle : unselectedItemTextStyle,
          ),
          if (isSelected && selectIcon != null) selectIcon!,
        ],
      ),
    );
  }

  /// Divider widget between items.
  Widget get dividerWidget =>
      widget.popupMenuDecoration?.dividerWidget ?? const SizedBox.shrink();

  /// Builds a divider entry.
  _RoundedPopupMenuItem<T> _buildDivider(BuildContext context) =>
      _RoundedPopupMenuItem(
        enabled: false,
        itemHeight: 1,
        child: dividerWidget,
      );

  /// Inner padding.
  EdgeInsetsGeometry get padding =>
      widget.popupDecoration?.padding ?? EdgeInsets.zero;

  /// Border radius.
  BorderRadius get borderRadius =>
      widget.popupDecoration?.borderRadius ?? BorderRadius.circular(8);

  /// Shadow elevation.
  double get elevation => widget.popupDecoration?.elevation ?? 10;

  /// Tap ripple radius.
  double get splashRadius => widget.popupDecoration?.splashRadius ?? 0;

  /// Shadow color.
  Color get shadowColor =>
      widget.popupDecoration?.shadowColor ??
      Colors.black.withValues(alpha: 0.1);

  /// Label text style.
  TextStyle get textStyle =>
      widget.popupDecoration?.textStyle ??
      const TextStyle(
        color: Colors.black,
        fontSize: 14,
      );

  /// Expand icon.
  Widget get icon =>
      widget.popupDecoration?.icon ?? const Icon(Icons.arrow_drop_down);

  /// Menu offset.
  Offset get offset =>
      widget.popupMenuDecoration?.offset ?? const Offset(0, 30);

  /// Menu background color.
  Color get color => widget.popupMenuDecoration?.color ?? Colors.white;

  @override
  Widget build(BuildContext context) => PopupMenuButton<T>(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        initialValue: widget.initialValue,
        menuPadding: EdgeInsets.zero,
        borderRadius: borderRadius,
        offset: offset,
        color: color,
        elevation: elevation,
        surfaceTintColor: widget.popupDecoration?.surfaceTintColor,
        enabled: widget.enabled,
        constraints: widget.popupMenuDecoration?.constraints,
        popUpAnimationStyle: widget.popupMenuDecoration?.animationStyle,
        splashRadius: splashRadius,
        shadowColor: shadowColor,
        itemBuilder: (context) => widget.items
            .expand(
              (element) => [
                _buildMenuItem(context, element, widget.selectedItem),
                if (element != widget.items.last) _buildDivider(context),
              ],
            )
            .toList(),
        onSelected: (value) async {
          await _controller.reverse();
          widget.onSelected(value);
        },
        onOpened: () async => _controller.forward(),
        onCanceled: () async => _controller.reverse(),
        child: Container(
          padding: padding,
          width: widget.popupDecoration?.width,
          height: widget.popupDecoration?.height,
          alignment: widget.popupDecoration?.alignment,
          decoration: widget.popupDecoration?.decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.itemToString?.call(widget.selectedItem) ??
                    widget.selectedItem.toString(),
                style: textStyle,
              ),
              if (widget.popupDecoration?.gapWidget != null)
                widget.popupDecoration!.gapWidget!,
              RotationTransition(
                turns: Tween<double>(begin: 0, end: 1).animate(_controller),
                child: icon,
              ),
            ],
          ),
        ),
      );
}

/// Custom menu entry that supports a rounded ripple effect.
class _RoundedPopupMenuItem<T> extends PopupMenuEntry<T> {
  const _RoundedPopupMenuItem({
    required this.child,
    this.value,
    this.itemHeight = kMinInteractiveDimension,
    this.enabled = true,
    super.key,
    this.popupElementDecoration,
  });

  /// Entry value.
  final T? value;

  /// Entry content.
  final Widget child;

  /// Entry height.
  final double itemHeight;

  /// Whether the entry is enabled.
  final bool enabled;

  /// Popup menu item style.
  final TUIPopupElementDecoration? popupElementDecoration;

  @override
  State<_RoundedPopupMenuItem<T>> createState() =>
      _RoundedPopupMenuItemState<T>();

  @override
  double get height => itemHeight;

  @override
  bool represents(T? value) => value == this.value;
}

class _RoundedPopupMenuItemState<T> extends State<_RoundedPopupMenuItem<T>> {
  /// Tap ripple border radius.
  BorderRadius get rippleBorderRadius =>
      widget.popupElementDecoration?.rippleBorderRadius ??
      BorderRadius.circular(8);

  bool get enableRipple => widget.popupElementDecoration?.enableRipple ?? true;

  Color? get splashColor => widget.popupElementDecoration?.splashColor;

  /// Padding.
  EdgeInsetsGeometry get padding =>
      widget.popupElementDecoration?.padding ?? const EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) => enableRipple
      ? InkWell(
          borderRadius: rippleBorderRadius,
          splashColor: splashColor,
          onTap: widget.enabled
              ? () => Navigator.pop(context, widget.value)
              : null,
          child: _buildContent(),
        )
      : GestureDetector(
          onTap: widget.enabled
              ? () => Navigator.pop(context, widget.value)
              : null,
          child: _buildContent(),
        );

  Widget _buildContent() => Container(
        height: widget.height,
        padding: padding,
        decoration: widget.popupElementDecoration?.decoration,
        child: widget.child,
      );
}
