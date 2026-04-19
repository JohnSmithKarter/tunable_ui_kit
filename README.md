# tunable_ui_kit

Russian version: [README_RU.md](README_RU.md)

<p>
  <img src="lib/src/components/long_press_selection_wrapper/_docs/assets/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />
  <img src="lib/src/components/custom_drop_down_widget/_docs/assets/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />
  <img src="lib/src/components/popup_menu_widget/_docs/assets/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />
  <img src="lib/src/components/notification_banner/_docs/assets/notification_banner_screen.gif" width="240" alt="TUINotifications" />
</p>

## A library that contains useful widgets without dependencies on other libraries.
#### The latest template changes were made on `Flutter version 3.35.7` and `Dart version 3.9.2`

#### <u>The library is designed for iOS and Android, but it can also work on other platforms.</u>

## Dependencies

- Analyzer: [lint](https://pub.dev/packages/lint)
  - Linter rules: [Linter rules](https://dart.dev/tools/linter-rules)

## Installation

To use the library in your project:

1. Add the dependency to your project's `pubspec.yaml`:

```yaml
dependencies:
  tunable_ui_kit: ^0.4.1
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

### TUISelectableItem

A widget for selecting multiple items.

<img src="lib/src/components/long_press_selection_wrapper/_docs/assets/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />

Docs:
[lib/src/components/long_press_selection_wrapper/_docs/tui_selectable_item_doc.md](lib/src/components/long_press_selection_wrapper/_docs/tui_selectable_item_doc.md)

Example:
[example/lib/usage_examples/tui_selectable_item_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_selectable_item_screen.dart)

### TUICustomDropdownWidget<T>

A highly customizable dropdown widget for selecting an item.

<img src="lib/src/components/custom_drop_down_widget/_docs/assets/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />

Docs:
[lib/src/components/custom_drop_down_widget/_docs/custom_drop_down_widget_doc.md](lib/src/components/custom_drop_down_widget/_docs/custom_drop_down_widget_doc.md)

Example:
[example/lib/usage_examples/tui_custom_dropdown_widget_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_custom_dropdown_widget_screen.dart)

### TUIPopupMenuWidget<T>

A highly customizable popup menu widget for selecting an item.

<img src="lib/src/components/popup_menu_widget/_docs/assets/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />

Docs:
[lib/src/components/popup_menu_widget/_docs/popup_menu_widget_doc.md](lib/src/components/popup_menu_widget/_docs/popup_menu_widget_doc.md)

Example:
[example/lib/usage_examples/tui_popup_menu_widget.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_popup_menu_widget.dart)

### TUINotifications

A highly customizable snackbar-like notification banner based on Flutter `Overlay`.

<img src="lib/src/components/notification_banner/_docs/assets/notification_banner_screen.gif" width="240" alt="TUINotifications" />

Docs:
[lib/src/components/notification_banner/_docs/notification_banner_doc.md](lib/src/components/notification_banner/_docs/notification_banner_doc.md)

Example:
[example/lib/usage_examples/tui_notifications_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_notifications_screen.dart)