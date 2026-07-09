# TUIToggleSwitch

Russian version: [tui_toggle_switch_screen_doc_ru.md](tui_toggle_switch_screen_doc_ru.md)

A highly customizable toggle switch widget for boolean state selection.

<img src="assets/tui_toggle_switch_screen.gif" width="240" alt="TUIToggleSwitch" />

## Quick start

```dart
bool _isEnabled = false;

void _onChanged(bool value) => setState(() => _isEnabled = value);

TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  initialValue: _isEnabled,
  onChanged: _onChanged,
);
```

## Example

[example/lib/usage_examples/tui_toggle_switch_screen.dart](https://github.com/JohnSmithKarter/tunable_ui_kit/blob/main/example/lib/usage_examples/tui_toggle_switch_screen.dart)

### Parameters

#### size

Size (height) of the toggle switch.

**Type:** `double` (required)

#### aspectRatio

Aspect ratio of the toggle switch (width / height).

**Type:** `double?`

**Default:** `1.5`

#### duration

Duration of the toggle animation.

**Type:** `Duration`

**Default:** `300ms`

#### curve

Animation curve for the toggle animation.

**Type:** `Curve`

**Default:** `Curves.easeInOut`

#### initialValue

Initial state of the toggle switch.

**Type:** `bool`

**Default:** `false`

#### enabled

Whether the toggle switch is enabled.

**Type:** `bool`

**Default:** `true`

#### margin

Margin around the toggle switch.

**Type:** `EdgeInsetsGeometry?`

**Default:** `null`

#### onChanged

Callback when the toggle value changes.

**Type:** `ValueChanged<bool>?`

**Default:** `null`

#### onBeforeToggle

Callback before the toggle value changes. Return `false` to prevent the toggle.

**Type:** `Future<bool> Function(bool newValue)?`

**Default:** `null`

#### settings

Style settings for the toggle switch (`TUIToggleSwitchSettings`).

**Type:** `TUIToggleSwitchSettings?`

**Default:** `null`

#### thumbSettings

Style settings for the thumb (`TUIToggleThumbSettings`).

**Type:** `TUIToggleThumbSettings?`

**Default:** `null`

## TUIToggleSwitchSettings

Style configuration for the toggle switch.

### Parameters

#### color

Color of the toggle switch when inactive.

**Type:** `Color?`

**Default:** `Colors.green[200]`

#### activeColor

Color of the toggle switch when active.

**Type:** `Color?`

**Default:** `Colors.green[200]`

#### borderRadius

Border radius of the toggle switch.

**Type:** `double?`

**Default:** `size / 2` (circular)

#### border

Border of the toggle switch.

**Type:** `BoxBorder?`

**Default:** `null`

#### boxShadow

Box shadow of the toggle switch.

**Type:** `List<BoxShadow>?`

**Default:** `null`

#### gradient

Gradient of the toggle switch.

**Type:** `Gradient?`

**Default:** `null`

#### image

Background image of the toggle switch.

**Type:** `DecorationImage?`

**Default:** `null`

#### opacity

Opacity of the toggle switch.

**Type:** `double?`

**Default:** `1.0` (enabled) or `0.5` (disabled)

## TUIToggleThumbSettings

Style configuration for the toggle switch thumb.

### Parameters

#### size

Size of the thumb.

**Type:** `double?`

**Default:** `size` (same as switch height)

#### color

Color of the thumb.

**Type:** `Color?`

**Default:** `Colors.green`

#### borderRadius

Border radius of the thumb.

**Type:** `double?`

**Default:** `size / 2` (circular)

#### gradient

Gradient of the thumb.

**Type:** `Gradient?`

**Default:** `null`

#### boxShadow

Box shadow of the thumb.

**Type:** `List<BoxShadow>?`

**Default:** `null`

#### image

Background image of the thumb.

**Type:** `DecorationImage?`

**Default:** `null`

#### border

Border of the thumb.

**Type:** `BoxBorder?`

**Default:** `null`

#### shape

Shape of the thumb.

**Type:** `BoxShape`

**Default:** `BoxShape.rectangle`

#### customThumb

Custom widget to use as the thumb instead of the default.

**Type:** `Widget?`

**Default:** `null`

## Examples

### Basic toggle switch

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  onChanged: (value) => print('Toggled: $value'),
);
```

### Toggle switch with custom colors

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  settings: TUIToggleSwitchSettings(
    color: Colors.grey[300],
    activeColor: Colors.blue,
  ),
  thumbSettings: TUIToggleThumbSettings(
    color: Colors.white,
  ),
);
```

### Toggle switch with custom thumb size

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  thumbSettings: TUIToggleThumbSettings(
    size: 35,
  ),
);
```

### Toggle switch with custom thumb widget

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  thumbSettings: TUIToggleThumbSettings(
    customThumb: Icon(
      Icons.circle_notifications,
      size: 38,
      color: Colors.blue,
    ),
  ),
);
```

### Toggle switch with gradient

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  settings: TUIToggleSwitchSettings(
    gradient: LinearGradient(
      colors: [Colors.red, Colors.blue],
    ),
  ),
);
```

### Disabled toggle switch

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  enabled: false,
  settings: TUIToggleSwitchSettings(
    opacity: 0.3,
  ),
);
```

### Toggle switch with validation

```dart
TUIToggleSwitch(
  size: 40,
  aspectRatio: 2,
  onBeforeToggle: (newValue) async {
    // Perform validation
    final isValid = await validateToggle(newValue);
    return isValid;
  },
  onChanged: (value) => print('Toggle confirmed: $value'),
);
```
