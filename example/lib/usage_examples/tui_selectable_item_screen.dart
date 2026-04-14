import 'package:flutter/material.dart';
import 'package:tunable_ui_kit/tunable_ui_kit.dart';

/// Usage example for [TUISelectableItem].
class TUISelectableItemScreen extends StatefulWidget {
  const TUISelectableItemScreen({super.key});

  @override
  State<TUISelectableItemScreen> createState() =>
      _TUISelectableItemScreenState();
}

class _TUISelectableItemScreenState extends State<TUISelectableItemScreen> {
  /// Selection mode
  bool _selectionMode = false;

  /// Selected items
  final List<int> _selectedItems = [];

  void _setSelectionMode(bool value) {
    if (!value) {
      _selectedItems.clear();
    }
    setState(() => _selectionMode = value);
  }

  /// Select an item
  void _selectItem(int index) {
    if (_selectedItems.contains(index)) {
      setState(() => _selectedItems.remove(index));
    } else {
      setState(() => _selectedItems.add(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TUISelectableItem example'),
      ),
      body: ListView.separated(
        itemCount: 14,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => TUISelectableItem(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          enableRipple: true,
          rippleBorderRadius: BorderRadius.circular(16),
          onSelectionModeChanged: _setSelectionMode,
          selectionMode: _selectionMode,
          select: () => _selectItem(index),
          onTap: () => debugPrint('Item $index tapped'),
          isSelected: _selectedItems.contains(index),
          offset: const Offset(80, 0),
          selectedWidget: const Icon(Icons.radio_button_checked),
          unselectedWidget: const Icon(Icons.radio_button_unchecked),
          child: _ItemWidget(index: index),
        ),
      ),
    );
  }
}

/// Example item widget
class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.index});

  /// Item index
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('Item - $index'),
    );
  }
}
