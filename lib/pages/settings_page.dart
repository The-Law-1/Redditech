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
        buildSwitch()
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
}
