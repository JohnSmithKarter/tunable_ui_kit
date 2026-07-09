import 'package:flutter/material.dart';
import 'package:tunable_ui_kit/tunable_ui_kit.dart';

/// Usage example for [TUIToggleSwitch].
class TUIToggleSwitchScreen extends StatefulWidget {
  const TUIToggleSwitchScreen({super.key});

  @override
  State<TUIToggleSwitchScreen> createState() => _TUIToggleSwitchScreenState();
}

class _TUIToggleSwitchScreenState extends State<TUIToggleSwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TUIToggleSwitch example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TUIToggleSwitch(size: 40, aspectRatio: 2),
              TUIToggleSwitch(
                size: 40,
                aspectRatio: 2,
                enabled: false,
                settings: TUIToggleSwitchSettings(opacity: 0.3),
              ),
              TUIToggleSwitch(
                size: 40,
                aspectRatio: 3,
                settings: TUIToggleSwitchSettings(borderRadius: 10),
                thumbSettings:
                    TUIToggleThumbSettings(size: 50, borderRadius: 8),
              ),
              TUIToggleSwitch(
                size: 40,
                aspectRatio: 2,
                settings: TUIToggleSwitchSettings(
                  color: Colors.white,
                  activeColor: Colors.green[200]!,
                  border: Border.all(color: Colors.green),
                ),
                thumbSettings: TUIToggleThumbSettings(
                  customThumb: Icon(
                    Icons.circle_notifications,
                    size: 38,
                    color: Colors.green,
                  ),
                ),
              ),
              TUIToggleSwitch(
                size: 40,
                aspectRatio: 8,
                settings: TUIToggleSwitchSettings(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.blue,
                      Colors.purple,
                    ],
                  ),
                ),
                thumbSettings: TUIToggleThumbSettings(
                  customThumb: Icon(
                    Icons.circle,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
