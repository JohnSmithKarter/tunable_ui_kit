import 'package:flutter/material.dart';
import 'package:tunable_ui_kit/tunable_ui_kit.dart';

/// Usage example for [TUINotifications].
///
/// This screen demonstrates how notifications behave with different
/// configuration options.
///
/// It demonstrates:
///
/// - `dismiss()`
/// - `duration: null` (sticky notification)
/// - Animation customization
/// - `swipeToDismiss`
class TUINotificationsScreen extends StatefulWidget {
  const TUINotificationsScreen({super.key});

  @override
  State<TUINotificationsScreen> createState() => _TUINotificationsScreenState();
}

class _TUINotificationsScreenState extends State<TUINotificationsScreen> {
  /// Demonstrates `TUINotifications.dismiss()`.
  ///
  /// Shows a sticky notification and dismisses it programmatically after a
  /// short delay.
  void _showExample1ProgrammaticDismiss() {
    TUINotifications.show(
      context,
      message: 'Notification: programmatic dismiss() in 1s',
      displayBehavior: TUINotificationDisplayBehavior.replace,
      duration: null,
      showCloseIcon: false,
      swipeToDismiss: false,
      style: const TUINotificationStyle(
        icon: Icons.timer_outlined,
      ),
    );

    Future<void>.delayed(const Duration(seconds: 1), TUINotifications.dismiss);
  }

  /// Demonstrates sticky notifications (`duration: null`).
  ///
  /// Also enables `barrierDismissible` so the user can tap outside to dismiss.
  void _showExample2Sticky() {
    TUINotifications.show(
      context,
      message: 'Notification: sticky (duration: null)',
      displayBehavior: TUINotificationDisplayBehavior.replace,
      duration: null,
      barrierDismissible: true,
      style: const TUINotificationStyle(
        icon: Icons.push_pin_outlined,
      ),
    );
  }

  /// Demonstrates animation customization and `margin`.
  void _showExample3Animation() {
    TUINotifications.show(
      context,
      message: 'Notification: custom animation',
      displayBehavior: TUINotificationDisplayBehavior.replace,
      margin: const EdgeInsets.only(top: 48),
      animationDuration: const Duration(milliseconds: 650),
      reverseAnimationDuration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutBack,
      style: const TUINotificationStyle(
        icon: Icons.motion_photos_on_outlined,
      ),
    );
  }

  /// Demonstrates `swipeToDismiss`.
  ///
  /// Shows a sticky notification at the bottom and disables the close icon.
  void _showExample4SwipeToDismiss() {
    TUINotifications.show(
      context,
      message: 'Swipe to dismiss',
      position: TUINotificationPosition.bottom,
      displayBehavior: TUINotificationDisplayBehavior.replace,
      duration: null,
      showCloseIcon: false,
      barrierDismissible: false,
      swipeToDismiss: true,
      style: const TUINotificationStyle(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        icon: Icons.swipe,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TUINotifications example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 30,
          children: [
            const SizedBox(height: 4),
            _ExampleItem(
              title: '1) dismiss()',
              subtitle: 'Programmatic dismiss in 1 second',
              onPressed: _showExample1ProgrammaticDismiss,
            ),
            _ExampleItem(
              title: '2) duration: null',
              subtitle: 'Sticky (tap outside to dismiss)',
              onPressed: _showExample2Sticky,
            ),
            _ExampleItem(
              title: '3) animationDuration/curve',
              subtitle: 'Custom animation',
              onPressed: _showExample3Animation,
            ),
            _ExampleItem(
              title: '4) swipeToDismiss',
              subtitle: 'Bottom: swipe down to dismiss',
              onPressed: _showExample4SwipeToDismiss,
            ),
          ],
        ),
      ),
    );
  }
}

/// Example widget for demonstrating notification items.
class _ExampleItem extends StatelessWidget {
  const _ExampleItem({
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  /// Title of the example item.
  final String title;

  /// Subtitle of the example item.
  final String subtitle;

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          FilledButton(
            onPressed: onPressed,
            child: Text(subtitle),
          ),
        ],
      );
}
