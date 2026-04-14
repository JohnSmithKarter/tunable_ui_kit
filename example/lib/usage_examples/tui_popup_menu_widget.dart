import 'package:flutter/material.dart';
import 'package:tunable_ui_kit/tunable_ui_kit.dart';

/// Example usage of [TUIPopupMenuWidget].
class TUIPopupMenuWidgetScreen extends StatefulWidget {
  const TUIPopupMenuWidgetScreen({super.key});

  @override
  State<TUIPopupMenuWidgetScreen> createState() =>
      _TUIPopupMenuWidgetScreenState();
}

class _TUIPopupMenuWidgetScreenState extends State<TUIPopupMenuWidgetScreen> {
  /// Items list.
  final items = <String>[
    'item 1',
    'item 2',
    'item 3',
    'item 4',
    'item 5',
    'item 6',
    'item 7',
    'item 8',
  ];

  /// Selected item.
  String? _selectedItem;

  /// Selected enum item.
  TestEnum? _selectedItemEnum;

  /// String item selection.
  void _onSelected(String item) => setState(() => _selectedItem = item);

  /// Enum item selection.
  void _onItemSelectedEnum(TestEnum item) =>
      setState(() => _selectedItemEnum = item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TUIPopupMenuWidget example'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            spacing: 10,
            children: [
              const SizedBox(height: 10),
              Text(
                'items = <String>',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TUIPopupMenuWidget<String>(
                items: items,
                selectedItem: _selectedItem ?? 'select item',
                onSelected: _onSelected,
              ),
              const SizedBox(height: 10),
              Text(
                'items = TestEnum {test1, test2, test3}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TUIPopupMenuWidget<TestEnum>(
                items: TestEnum.values,
                selectedItem: _selectedItemEnum ?? TestEnum.test1,
                onSelected: _onItemSelectedEnum,
                itemToString: (item) => item.title,
                popupElementDecoration: const TUIPopupElementDecoration(
                  enableRipple: true,
                  splashColor: Colors.black12,
                  selectIcon: Icon(Icons.check),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Test enum.
enum TestEnum {
  test1,
  test2,
  test3;

  /// Item title.
  String get title => switch (this) {
        test1 => 'test1',
        test2 => 'test2',
        test3 => 'test3',
      };
}
