# TUISelectableItem

Russian version: [tui_selectable_item_doc_ru.md](tui_selectable_item_doc_ru.md)

A widget for selecting multiple items.

<img src="assets/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />


## Quick start

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
```

## Example

[example/lib/usage_examples/tui_selectable_item_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_selectable_item_screen.dart)

### Parameters

#### child

Item child widget.

#### onSelectionModeChanged

Callback invoked on long press.

Receives the next selection mode value (`!selectionMode`).

#### selectionMode

Whether selection mode is active.

#### select

Selection callback (usually toggles selected/unselected).

#### onTap

Normal tap callback when `selectionMode == false`.

#### isSelected

Whether the item is selected.

#### enabled

Enables/disables selection functionality only.

When `false`, `onLongPress` is disabled.

#### animationDuration

Duration of shift/icon switch animations.

#### selectionColor

Selection control color.

If you use the default icons, the color is applied via `IconTheme`.

#### offset

Shift offset when selection mode is active.

Default is `Offset(40, 0)`.

#### selectedWidget

Widget shown for the selected state.

#### unselectedWidget

Widget shown for the unselected state.

#### padding

Padding around `child`.

#### controlSide

Which side the selection control appears on and which direction the content
shifts.

Values: `TUIControlSide.start` / `TUIControlSide.end`.

#### enableRipple

Enables Material ripple effect.

Disabled by default.

#### rippleBorderRadius

Border radius for Material ripple clipping.
