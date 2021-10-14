import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings', style: TextStyle(fontSize: 60)),
      ),
    );
  }
}

class _MySettingsPageState extends State<SettingsPage> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget buildSwitch() => Switch.adaptive(
    value: value,
    onChanged: (value) => setState(() => this.value = value),
  );
}
