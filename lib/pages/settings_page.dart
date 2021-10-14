import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool one = true;
  bool soundValue = true;
  bool three = true;
  bool four = true;
  bool five = true;
  bool six = true;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            buildButtonZone(
                child: buildApparenceSwitch(),
                text: one ? "One" : "Off"),
            buildButtonZone(
                child: buildSoundSwitch(),
                text: soundValue ? "Sound On" : "Sound Off"),
            buildButtonZone(
                child: build3Switch(),
                text: three ? "On" : "Off"),
            buildButtonZone(
                child: build4Switch(),
                text: four ? "On" : "Off"),
            buildButtonZone(
                child: build5Switch(),
                text: five ? "On" : "Off"),
            buildButtonZone(
                child: build6Switch(),
                text: six ? "On" : "Off"),
          ],
        ))));
  }

  //don't work because the val variable don't change when setState
  /*Widget buildSwitchButton(colorOn, colorOff, val) => Transform.scale (
    scale: 2,
    child: Switch.adaptive(
      activeColor: colorOn,
      activeTrackColor: colorOn.withOpacity(0.4),
      inactiveThumbColor: colorOff,
      inactiveTrackColor: colorOff.withOpacity(0.3),
      value: val, 
      onChanged: (value) => setState(() => val = value)
      )
  );*/

  Widget buildApparenceSwitch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
          activeColor: Colors.yellow,
          activeTrackColor: Colors.yellow.withOpacity(0.3),
          inactiveThumbColor: Colors.grey[400],
          inactiveTrackColor: Colors.grey.withOpacity(0.4),
          value: one,
          onChanged: (value) => setState(() => one = value),
        ),
      );

  Widget buildSoundSwitch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
            activeColor: Colors.green[600],
            activeTrackColor: Colors.green.withOpacity(0.4),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            value: soundValue,
            onChanged: (value) => setState(() => soundValue = value)),
      );

  Widget build3Switch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
          activeColor: Colors.orange,
          activeTrackColor: Colors.orange.withOpacity(0.4),
          inactiveThumbColor: Colors.grey[400],
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
          value: three,
          onChanged: (value) => setState(() => three = value),
        ),
      );

  Widget build4Switch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
            activeColor: Colors.blue[600],
            activeTrackColor: Colors.blue.withOpacity(0.4),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            value: four,
            onChanged: (value) => setState(() => four = value)),
      );

  Widget build5Switch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
          activeColor: Colors.purple,
          activeTrackColor: Colors.purple.withOpacity(0.4),
          inactiveThumbColor: Colors.grey[400],
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
          value: five,
          onChanged: (value) => setState(() => five = value),
        ),
      );

  Widget build6Switch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
            activeColor: Colors.cyan[600],
            activeTrackColor: Colors.cyan.withOpacity(0.4),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            value: six,
            onChanged: (value) => setState(() => six = value)),
      );

  Widget buildButtonZone(
          {required Widget child,
          required String text}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
