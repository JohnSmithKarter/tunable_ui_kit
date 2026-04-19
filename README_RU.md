# tunable_ui_kit

English version: [README.md](README.md)

<p>
  <img src="lib/src/components/long_press_selection_wrapper/_docs/assets/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />
  <img src="lib/src/components/custom_drop_down_widget/_docs/assets/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />
  <img src="lib/src/components/popup_menu_widget/_docs/assets/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />
  <img src="lib/src/components/notification_banner/_docs/assets/notification_banner_screen.gif" width="240" alt="TUINotifications" />
</p>

## Библиотека, содержащая разные необходимые виджеты, без зависимостей от других библиотек.
#### Последние изменения шаблона были произведены на `Flutter version 3.35.7` `Dart version 3.9.2`

#### <u>Библиотека разрабатывается для использования на IOS и Android, но также может работать и на других платформах.</u>

## Зависимости:
- Анализатор: [lint](https://pub.dev/packages/lint)
  - Правила линтера: [Linter rules](https://dart.dev/tools/linter-rules)

## Установка

Для использования библиотеки в вашем проекте:

1. Добавьте следующую зависимость в `pubspec.yaml` вашего проекта:

```yaml
dependencies:
  tunable_ui_kit: ^0.4.1
```

2. Выполните команду для загрузки зависимостей:

```bash
flutter pub get
```

### Важные замечания

- Для продакшен использования рекомендуется указывать конкретную версию вместо `any`.
- Для обновления зависимости до последней совместимой версии используйте: `flutter pub upgrade`.

Для локальной разработки можно использовать path:

```yaml
dependencies:
  tunable_ui_kit:
    path: ../tunable_ui_kit
```

## Примеры использования виджетов:

### TUISelectableItem

Виджет для выбора нескольких элементов одновременно.

<img src="lib/src/components/long_press_selection_wrapper/_docs/assets/tui_selectable_item_screen.gif" width="240" alt="TUISelectableItem" />

Документация:
[lib/src/components/long_press_selection_wrapper/_docs/tui_selectable_item_doc_ru.md](lib/src/components/long_press_selection_wrapper/_docs/tui_selectable_item_doc_ru.md)

Пример:
[example/lib/usage_examples/tui_selectable_item_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_selectable_item_screen.dart)

### TUICustomDropdownWidget<T>

Тонко кастомизируемый DropDown для выбора элемента.

<img src="lib/src/components/custom_drop_down_widget/_docs/assets/tui_custom_dropdown_widget_screen.gif" width="240" alt="TUICustomDropdownWidget" />

Документация:
[lib/src/components/custom_drop_down_widget/_docs/custom_drop_down_widget_doc_ru.md](lib/src/components/custom_drop_down_widget/_docs/custom_drop_down_widget_doc_ru.md)

Пример:
[example/lib/usage_examples/tui_custom_dropdown_widget_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_custom_dropdown_widget_screen.dart)

### TUIPopupMenuWidget<T>

Тонко кастомизируемое меню для выбора элемента.

<img src="lib/src/components/popup_menu_widget/_docs/assets/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />

Документация:
[lib/src/components/popup_menu_widget/_docs/popup_menu_widget_doc_ru.md](lib/src/components/popup_menu_widget/_docs/popup_menu_widget_doc_ru.md)

Пример:
[example/lib/usage_examples/tui_popup_menu_widget.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_popup_menu_widget.dart)

### TUINotifications

Максимально настраиваемый snackbar-подобный баннер уведомлений на базе Flutter `Overlay`.

<img src="lib/src/components/notification_banner/_docs/assets/notification_banner_screen.gif" width="240" alt="TUINotifications" />

Документация:
[lib/src/components/notification_banner/_docs/notification_banner_doc_ru.md](lib/src/components/notification_banner/_docs/notification_banner_doc_ru.md)

Пример:
[example/lib/usage_examples/tui_notifications_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_notifications_screen.dart)
