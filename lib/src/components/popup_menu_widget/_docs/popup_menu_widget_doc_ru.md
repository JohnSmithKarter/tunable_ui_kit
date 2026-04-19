# TUIPopupMenuWidget<T>

English version: [popup_menu_widget_doc.md](popup_menu_widget_doc.md)

Тонко кастомизируемое меню для выбора элемента.

<img src="assets/tui_popup_menu_widget_screen.gif" width="240" alt="TUIPopupMenuWidget" />

## Быстрый старт

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

## Пример

[example/lib/usage_examples/tui_popup_menu_widget.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_popup_menu_widget.dart)

### Параметры

#### items

Список элементов.

#### selectedItem

Выбранный элемент.

#### initialValue

Начальное значение.

#### onSelected

Функция выбора элемента.

#### itemToString

Функция для форматирования элемента в текст.

Если не указана, используется `toString()` для `T`.

#### enabled

Флаг доступности виджета.

#### popupDecoration

Стилизация попапа (`TUIPopupDecoration`).

#### popupMenuDecoration

Стилизация меню (`TUIPopupMenuDecoration`).

#### popupElementDecoration

Стилизация элемента меню (`TUIPopupElementDecoration`).
