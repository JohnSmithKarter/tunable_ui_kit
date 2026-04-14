import 'package:flutter/material.dart';
import 'package:tunable_ui_kit/tunable_ui_kit.dart';

/// Usage example for [TUICustomDropdownWidget].
class TUICustomDropdownWidgetScreen extends StatefulWidget {
  const TUICustomDropdownWidgetScreen({super.key});

  @override
  State<TUICustomDropdownWidgetScreen> createState() =>
      _TUICustomDropdownWidgetScreenState();
}

class _TUICustomDropdownWidgetScreenState
    extends State<TUICustomDropdownWidgetScreen> {
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
    'item 9',
    'item 10',
    'item 11',
    'item 12',
  ];

  /// Selected item.
  String? _selectedItem;

  /// Selected enum item.
  TestEnum? _selectedItemEnum;

  /// Selects an item.
  void _onItemSelected(String item) => setState(() => _selectedItem = item);

  /// Selects an enum item.
  void _onItemSelectedEnum(TestEnum item) =>
      setState(() => _selectedItemEnum = item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TUICustomDropdownWidget example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 10,
          children: [
            const SizedBox(height: 10),
            Text(
              'items = <String>[]',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TUICustomDropdownWidget<String>(
              items: items,
              selectedItem: _selectedItem,
              title: 'select item',
              onItemSelected: _onItemSelected,
              decoration: TUICustomDropdownDecoration(
                enableRipple: false,
                selectedItemTextStyle: const TextStyle(color: Colors.red),
                titleStyle: const TextStyle(color: Colors.green),
              ),
              itemDecoration: TUICustomDropdownItemDecoration(
                enableRipple: false,
              ),
            ),
            Text(
              'items = TestEnum {test1, test2, test3}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TUICustomDropdownWidget<TestEnum>(
              items: TestEnum.values,
              selectedItem: _selectedItemEnum,
              title: 'select item enum',
              onItemSelected: _onItemSelectedEnum,
              itemToString: (item) => item.title,
            ),
          ],
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
