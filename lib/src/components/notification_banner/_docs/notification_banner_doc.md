# TUINotifications (Notification banner)

[Документация на русском](notification_banner_doc_ru.md)

`TUINotifications` is a lightweight notification banner system built on top of Flutter `Overlay`.

It is designed as a single, highly customizable “snackbar-like” banner:

- You can use the default banner UI and customize it with `TUINotificationStyle`.
- Or fully replace the UI with `TUINotificationBuilder`.

## Quick start

```dart
TUINotifications.show(
  context,
  message: 'Saved',
);
```

## Behavior

`TUINotifications` uses an `OverlayEntry` and manages:

- Positioning (top / bottom)
- Fade + slide animation
- Auto-dismiss timer (optional)
- Concurrency behavior (replace / queue / ignore)

## TUINotifications.show()

```dart
TUINotifications.show(
  context,
  message: 'Profile updated',
  position: TUINotificationPosition.top,
  displayBehavior: TUINotificationDisplayBehavior.replace,
  duration: const Duration(seconds: 2),
  actionText: 'Undo',
  onAction: () {
    // ...
  },
  showCloseIcon: true,
);
```

### Parameters

#### message

Message text shown by the default banner UI.

If you provide `builder`, `message` is not used automatically (you can still use it manually inside your custom builder).

#### position

`TUINotificationPosition.top` or `TUINotificationPosition.bottom`.

The banner is aligned to the selected edge and respects safe area insets.

#### displayBehavior

Controls what happens when `show()` is called while another notification is already visible:

- `TUINotificationDisplayBehavior.replace`
  - Dismisses the current notification (awaiting its exit animation) and then shows the new one.
- `TUINotificationDisplayBehavior.queue`
  - Enqueues new requests and displays them sequentially.
- `TUINotificationDisplayBehavior.ignoreIfVisible`
  - Ignores calls while a notification is visible.

#### duration

Auto-dismiss duration.

- If `duration` is `null` or `Duration.zero`, the notification is **sticky** and will stay visible until dismissed:
  - by close icon (`showCloseIcon: true`)
  - by swipe (if enabled)
  - by barrier tap (if enabled)
  - or programmatically via `TUINotifications.dismiss()`

#### actionText / onAction

Optional action button for the default banner UI.

If both `actionText` and `onAction` are provided, the button is shown.

#### showCloseIcon

Whether the default banner shows a close icon.

If you provide `builder`, you control closing UI yourself.

#### style

Optional `TUINotificationStyle` that customizes the default banner UI.

Only applied when `builder == null`.

#### builder

Optional `TUINotificationBuilder` that fully overrides the banner widget.

Signature:

```dart
typedef TUINotificationBuilder = Widget Function(
  BuildContext context,
  VoidCallback dismiss,
);
```

Important:

- If `builder != null`, the default banner is not used.
- You must call `dismiss()` from your custom UI (for example, in a tap handler) to close the notification.

#### barrierDismissible

If true, tapping outside the banner dismisses the notification.

#### swipeToDismiss

If true, the banner can be dismissed by swipe gesture:

- `top` position: swipe up
- `bottom` position: swipe down

#### animationDuration / reverseAnimationDuration / curve

Controls the entrance and exit animation timing.

- `animationDuration`: how fast the banner appears
- `reverseAnimationDuration`: how fast it disappears
- `curve`: slide animation curve

#### margin

Extra outer margin around the banner.

This margin is added on top of:

- safe area insets
- base padding (`12px` from the edge)

Example (push the banner lower on the screen):

```dart
TUINotifications.show(
  context,
  message: 'Custom offset',
  margin: const EdgeInsets.only(top: 48),
);
```

## Public control methods

### TUINotifications.dismiss()

Dismisses the currently shown notification.

Returns a `Future` that completes after the exit animation finishes.

```dart
await TUINotifications.dismiss();
```

### TUINotifications.clearQueue()

Clears pending queued notifications.

Does not dismiss the currently visible notification.

```dart
TUINotifications.clearQueue();
```

## TUINotificationStyle

`TUINotificationStyle` customizes the default `TUINotificationBanner`.

Example:

```dart
TUINotifications.show(
  context,
  message: 'Success-like',
  style: const TUINotificationStyle(
    backgroundColor: Color(0xFF16A34A),
    foregroundColor: Colors.white,
    icon: Icons.check_circle_outline,
    borderRadius: BorderRadius.all(Radius.circular(18)),
  ),
);
```

### Style fields

- `backgroundColor`: background color of the banner
- `foregroundColor`: default foreground color for text and icons
- `icon`: leading icon
- `iconColor`: icon color override
- `iconSize`: icon size override
- `borderRadius`: border radius for the banner container
- `boxShadow`: shadow list
- `constraints`: layout constraints (min height / max width)
- `padding`: inner content padding
- `messageTextStyle`: message text style
- `maxLines`: message max lines
- `overflow`: message overflow behavior
- `actionTextStyle`: action label style
- `actionButtonStyle`: action button style
- `closeIcon`: close icon
- `closeIconColor`: close icon color override

## Full UI override with builder

If you need a completely custom layout (multiple lines, custom widgets, etc.), use `builder`:

```dart
TUINotifications.show(
  context,
  message: 'Ignored by default UI',
  duration: null,
  builder: (context, dismiss) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: dismiss,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Custom builder banner (tap to dismiss)',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
```