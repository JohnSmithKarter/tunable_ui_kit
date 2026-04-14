import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'custom_dropdown_item_widget.dart';
import 'custom_dropdown_menu_widget.dart';
import 'custom_dropdown_styles.dart';

/// Styled dropdown widget.
class TUICustomDropdownWidget<T> extends StatefulWidget {
  const TUICustomDropdownWidget({
    required this.items,
    required this.title,
    required this.onItemSelected,
    super.key,
    this.selectedItem,
    this.itemToString,
    this.active = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.decoration,
    this.menuDecoration,
    this.itemDecoration,
  });

  /// List of items.
  final List<T> items;

  /// Dropdown title.
  final String title;

  /// Callback invoked when an item is selected.
  final Function(T) onItemSelected;

  /// Selected item.
  final T? selectedItem;

  /// Whether the dropdown is enabled for interaction.
  final bool active;

  /// Function used to format an item to text.
  ///
  /// If not provided, the default `toString()` is used for [T].
  final String Function(T value)? itemToString;

  /// Expand/collapse animation duration.
  final Duration animationDuration;

  /// Expand/collapse animation curve.
  final Curve curve;

  /// Dropdown widget style.
  final TUICustomDropdownDecoration? decoration;

  /// Dropdown menu style.
  final TUICustomDropdownMenuDecoration? menuDecoration;

  /// Dropdown menu item style.
  final TUICustomDropdownItemDecoration? itemDecoration;

  @override
  State<TUICustomDropdownWidget> createState() =>
      _TUICustomDropdownWidgetState<T>();
}

class _TUICustomDropdownWidgetState<T> extends State<TUICustomDropdownWidget<T>>
    with SingleTickerProviderStateMixin {
  /// Whether the dropdown menu is expanded.
  bool _isExpanded = false;

  /// Selected item.
  T? _selectedItem;

  /// Dropdown overlay entry.
  OverlayEntry? _overlayEntry;

  /// Layer link for the overlay.
  final LayerLink _layerLink = LayerLink();

  /// Animation controller.
  late AnimationController _animationController;

  /// Expand/collapse animation.
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.selectedItem != null) {
      _selectedItem = widget.selectedItem as T;
    }
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(covariant TUICustomDropdownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      _selectedItem = widget.selectedItem;
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  /// Removes the overlay.
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// Toggles the dropdown.
  Future<void> _toggleDropdown(BuildContext context) async {
    if (_isExpanded) {
      await _animationController.reverse();
      _removeOverlay();
      if (!mounted) return;
      setState(() => _isExpanded = false);
    } else {
      _showMenu(context);
      _animationController.forward();
      setState(() => _isExpanded = true);
    }
  }

  /// Selects an item.
  Future<void> _selectItem(BuildContext context, T item) async {
    setState(() => _selectedItem = item);
    widget.onItemSelected(item);
    await _toggleDropdown(context);
  }

  /// Returns a separator widget between items.
  Widget _getSeparator(T item) {
    if (widget.decoration?.elementSeparator != null &&
        item != widget.items.last) {
      return widget.decoration!.elementSeparator!;
    }
    return const SizedBox.shrink();
  }

  /// Shows the dropdown menu.
  void _showMenu(BuildContext context) {
    /// Gets the RenderBox for the current context.
    final renderBox = context.findRenderObject()! as RenderBox;

    /// Gets RenderBox size.
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () async => _toggleDropdown(context),
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              child: TUICustomDropdownMenuWidget(
                decoration: widget.menuDecoration,
                animation: _expandAnimation,
                items: widget.items
                    .expand(
                      (item) => [
                        TUICustomDropdownItemWidget(
                          decoration: widget.itemDecoration,
                          title: widget.itemToString?.call(item) ??
                              item.toString(),
                          onTap: () async => _selectItem(context, item),
                        ),
                        _getSeparator(item),
                      ],
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );

    /// Inserts overlay into the overlay stack.
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Returns the displayed title.
  String _getTitle() {
    if (_selectedItem != null) {
      return widget.itemToString?.call(_selectedItem as T) ??
          _selectedItem.toString();
    } else {
      return widget.title;
    }
  }

  /// Whether the dropdown can be interacted with.
  bool get active => widget.items.length > 1 && widget.active;

  /// Whether to enable ripple effect.
  bool get _enableRipple => widget.decoration?.enableRipple ?? true;

  /// Title text style.
  TextStyle get _titleStyle {
    final defaultStyle = widget.decoration?.titleStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        );

    if (_selectedItem != null) {
      return widget.decoration?.selectedItemTextStyle ?? defaultStyle;
    }

    return defaultStyle;
  }

  /// Dropdown container decoration.
  Decoration get _decoration =>
      widget.decoration?.decoration ??
      BoxDecoration(
        border: Border.all(
          color: TUIColors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      );

  /// Ripple radius.
  BorderRadius get _rippleRadius =>
      widget.decoration?.rippleRadius ?? BorderRadius.circular(16);

  /// Inner padding.
  EdgeInsetsGeometry get _padding =>
      widget.decoration?.padding ??
      const EdgeInsets.symmetric(horizontal: 12, vertical: 14);

  /// Expand indicator icon.
  Widget get _expandIcon =>
      widget.decoration?.expandIcon ?? const Icon(Icons.arrow_drop_down);

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: !_isExpanded,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          if (_isExpanded) {
            await _toggleDropdown(context);
          }
        },
        child: CompositedTransformTarget(
          link: _layerLink,
          child: _enableRipple
              ? InkWell(
                  onTap: active ? () async => _toggleDropdown(context) : null,
                  borderRadius: _rippleRadius,
                  child: _buildDropdownContent(),
                )
              : GestureDetector(
                  onTap: active ? () async => _toggleDropdown(context) : null,
                  child: _buildDropdownContent(),
                ),
        ),
      );

  Widget _buildDropdownContent() => Container(
        height: widget.decoration?.height,
        width: widget.decoration?.width,
        padding: _padding,
        decoration: _decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _getTitle(),
                style: _titleStyle,
                overflow: widget.decoration?.titleOverflow,
                maxLines: widget.decoration?.titleMaxLines,
                textAlign: widget.decoration?.titleTextAlign,
              ),
            ),
            if (active)
              AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: widget.animationDuration,
                child: _expandIcon,
              ),
          ],
        ),
      );
}
