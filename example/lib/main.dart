import 'package:example/usage_examples/tui_custom_dropdown_widget_screen.dart';
import 'package:example/usage_examples/tui_notifications_screen.dart';
import 'package:example/usage_examples/tui_popup_menu_widget.dart';
import 'package:example/usage_examples/tui_selectable_item_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tunable_ui_kit examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('tunable_ui_kit examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Button(
              title: 'TUISelectableItem example',
              onPressed: () => _push(context, const TUISelectableItemScreen()),
            ),
            _Button(
              title: 'TUICustomDropdownWidget example',
              onPressed: () =>
                  _push(context, const TUICustomDropdownWidgetScreen()),
            ),
            _Button(
              title: 'TUIPopupMenuWidget example',
              onPressed: () => _push(context, const TUIPopupMenuWidgetScreen()),
            ),
            _Button(
              title: 'TUINotifications example',
              onPressed: () => _push(context, const TUINotificationsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
        ],
      ),
    );
  }
}
