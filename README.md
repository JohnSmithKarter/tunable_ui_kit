# tunable_ui_kit

Russian version: [README_RU.md](README_RU.md)

<p>
  <img src="gifs/tui_selectable_item_screen/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />
  <img src="gifs/tui_custom_dropdown_widget_screen/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />
  <img src="gifs/tui_popup_menu_widget_screen/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />
</p>

## A library that contains useful widgets without dependencies on other libraries.
#### The latest template changes were made on `Flutter version 3.35.7` and `Dart version 3.9.2`

#### <u>The library is designed for iOS and Android, but it can also work on other platforms.</u>

### Project structure

```
 tunable_ui_kit/
 ├── example/                  # Simple demo app showing how to use the library
 │   └── lib/
 │       └── usage_examples/   # Widget usage examples
 │
 ├── images/                   # Images used in README
 │   └── ...                   # Screenshots and other images
 │
 └── lib/                      # Library source code
     └── src/                  # Source
         ├── components/       # Widgets
         │   ├── button/       # Button component
         │   ├── card/         # Card component
         │   └── ...           # Other components
         │
         └── tunable_ui_kit.dart   # Main library export file
```

### Main directories

- `example/` - Demo application that shows widget usage examples
- `lib/src/components/` - Main library components
- `lib/tunable_ui_kit.dart` - File exporting the public API of the library

## Dependencies

- Analyzer: [lint](https://pub.dev/packages/lint)
  - Linter rules: [Linter rules](https://dart.dev/tools/linter-rules)

## Installation

To use the library in your project:

1. Add the dependency to your project's `pubspec.yaml`:

```yaml
dependencies:
  tunable_ui_kit: ^0.3.0
```

2. Fetch dependencies:

```bash
flutter pub get
```

### Notes

- For production usage, it is recommended to pin a specific version rather than using `any`.
- To upgrade to the latest compatible versions, use: `flutter pub upgrade`.

For local development you can use a path dependency:

```yaml
dependencies:
  tunable_ui_kit:
    path: ../tunable_ui_kit
```

## Widget usage examples

### 1 — TUISelectableItem
A widget for selecting multiple items:

<img src="gifs/tui_selectable_item_screen/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />

```dart
TUISelectableItem(
    onSelectionModeChanged: (value) => setState(() => _selectionMode = value),
    selectionMode: _selectionMode,
    select: () => _selectItem(index),
    onTap: () => debugPrint('Item tapped'),
    isSelected: _selectedItems.contains(index),
    enabled: true,
    controlSide: TUIControlSide.start,
    offset: const Offset(100, 0),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    selectedWidget: const Icon(Icons.check_box),
    unselectedWidget: const Icon(Icons.check_box_outline_blank),
    child: YourChildWidget(...),
);

 Parameters:
 
 - **child** — item child widget.
 - **onSelectionModeChanged** — callback invoked on long press; receives the next selection mode value (`!selectionMode`).
 - **selectionMode** — whether selection mode is active.
 - **select** — selection callback (usually toggles selected/unselected).
 - **onTap** — normal tap callback when `selectionMode == false`.
 - **isSelected** — whether the item is selected.
 - **enabled** — enables/disables selection functionality only (when `false`, `onLongPress` is disabled).
 - **animationDuration** — duration of shift/icon switch animations.
 - **selectionColor** — selection control color (optional; affects the default icons via `IconTheme`).
 - **offset** — shift offset when selection mode is active (default is `Offset(40, 0)`).
 - **selectedWidget** — widget shown for the selected state.
 - **unselectedWidget** — widget shown for the unselected state.
 - **padding** — padding around `child`.
 - **controlSide** — which side the selection control appears on and which direction the content shifts (`TUIControlSide.start` / `TUIControlSide.end`).
 - **enableRipple** — enables Material ripple effect (disabled by default).
 - **rippleBorderRadius** — border radius for Material ripple clipping.

### 2 — TUICustomDropdownWidget<T>
A highly customizable dropdown widget for selecting an item:

<img src="gifs/tui_custom_dropdown_widget_screen/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />

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

It also provides plenty of appearance settings:

```dart
TUICustomDropdownWidget<T>(
 ...
 itemToString: - Function to format an item to text.
 If not provided, the default `toString()` is used for [T].
 active: - Whether the dropdown is enabled for interaction.
 animationDuration: - Expand/collapse animation duration.
 curve: - Expand/collapse animation curve.
 decoration: TUICustomDropdownDecoration(
   elementSeparator: - Separator between items.
   titleStyle: - Dropdown title text style.
   selectedItemTextStyle: - Selected item text style.
   titleOverflow: - Title overflow behavior.
   titleMaxLines: - Title max lines.
   titleTextAlign: - Title alignment.
   height: - Dropdown height.
   width: - Dropdown width.
   decoration: - Container decoration.
   rippleRadius: - Tap ripple radius.
   enableRipple: - Enable/disable ripple effect.
   padding: - Inner padding.
   expandIcon: - Expand indicator icon.
 ),
 menuDecoration: TUICustomDropdownMenuDecoration(
   borderRadius: - Menu border radius.
   itemColor: - Menu item color.
   menuColor: - Menu container color.
   menuShadow: - Menu shadow.
   border: - Menu border.
   gradient: - Menu gradient.
   constraints: - Menu constraints.
   scrollbar settings
   scrollbarSettings: TUIScrollbarSettings(
     thumbVisibility: - Thumb visibility.
     trackVisibility: - Track visibility.
     thickness: - Thickness.
     radius: - Radius.
     interactive: - Interactive.
     scrollbarOrientation: - Orientation.
   ),
 ),
 itemDecoration: TUICustomDropdownItemDecoration(
   titleStyle: - Item title style.
   titleOverflow: - Item title overflow behavior.
   titleMaxLines: - Item title max lines.
   titleTextAlign: - Item title alignment.
   padding: - Padding.
   margin: - Margin.
   decoration: - Decoration.
   enableRipple: - Enable/disable ripple effect.
 ),
),
```

### 3 — TUIPopupMenuWidget<T>
A highly customizable popup menu widget for selecting an item:

<img src="gifs/tui_popup_menu_widget_screen/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />

```dart
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

String? _selectedItem;

void _onSelected(String item) => setState(() => _selectedItem = item);

TUIPopupMenuWidget<String>(
 items: items,
 selectedItem: _selectedItem ?? 'select item',
 onSelected: _onSelected,
);
```

It also provides plenty of appearance settings:

```dart
TUIPopupMenuWidget<T>(
 ...
 items: - Items list.
 selectedItem: - Selected item.
 initialValue: - Initial value.
 onSelected: - Selection callback.
 itemToString: - Function to format an item to text.
 If not provided, the default `toString()` is used for [T].
 enabled: - Whether the widget is enabled.
 popupDecoration: TUIPopupDecoration(
   padding: - Container padding.
   borderRadius: - Container border radius.
   elevation: - Shadow elevation.
   splashRadius: - Tap splash radius.
   shadowColor: - Shadow color.
   width: - Width.
   height: - Height.
   alignment: - Alignment.
   decoration: - Container decoration.
   gapWidget: - Widget used as a separator.
   textStyle: - Text style.
   icon: - Icon.
   surfaceTintColor: - Surface tint color (Material 3).
 ),
 popupMenuDecoration: TUIPopupMenuDecoration(
   offset: - Offset.
   color: - Color.
   constraints: - Constraints.
   animationStyle: - Animation style.
   dividerWidget: - Divider widget.
   animationDuration: - Animation duration.
 ),
 popupElementDecoration: TUIPopupElementDecoration(
   height: - Height.
   unselectedTextStyle: - Unselected text style.
   selectedTextStyle: - Selected text style.
   selectIcon: - Selection icon.
   rippleBorderRadius: - Tap ripple border radius.
   enableRipple: - Enable/disable ripple effect.
   splashColor: - Splash color for ripple effect.
   padding: - Padding.
   decoration: - Selected item decoration.
 ),
),