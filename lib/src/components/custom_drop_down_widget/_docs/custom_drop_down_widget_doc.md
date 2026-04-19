# TUICustomDropdownWidget<T>

Russian version: [custom_drop_down_widget_doc_ru.md](custom_drop_down_widget_doc_ru.md)

A highly customizable dropdown widget for selecting an item.

<img src="assets/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />

## Quick start

```dart
final items = <String>[
  'item 1',
  'item 2',
  'item 3',
];

String? _selectedItem;

void _onItemSelected(String item) => setState(() => _selectedItem = item);

TUICustomDropdownWidget<String>(
  items: items,
  selectedItem: _selectedItem,
  title: 'select item',
  onItemSelected: _onItemSelected,
);
```

## Example

[example/lib/usage_examples/tui_custom_dropdown_widget_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_custom_dropdown_widget_screen.dart)

### Parameters

#### items

Items list.

#### title

Dropdown title.

#### onItemSelected

Callback invoked when an item is selected.

#### selectedItem

Selected item.

#### itemToString

Function to format an item to text.

If not provided, the default `toString()` is used for `T`.

#### active

Whether the dropdown is enabled for interaction.

#### animationDuration

Expand/collapse animation duration.

#### curve

Expand/collapse animation curve.

#### decoration

Dropdown widget style (`TUICustomDropdownDecoration`).

#### menuDecoration

Dropdown menu style (`TUICustomDropdownMenuDecoration`).

#### itemDecoration

Dropdown menu item style (`TUICustomDropdownItemDecoration`).
