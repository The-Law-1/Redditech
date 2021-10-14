import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Center(
            child: Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        buildHeader(child: buildSwitch(), text: 'Dark Mode'),
      ],
    ))));
  }

  Widget buildSwitch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
          activeColor: Colors.green[600],
          activeTrackColor: Colors.black.withOpacity(0.4),
          inactiveThumbColor: Colors.redAccent,
          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );

  Widget buildHeader({
    required Widget child,
    required String text,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
