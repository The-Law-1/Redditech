import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> settingsConditions = [true, false, true, true, false, true];
  List<String> settingsString = [
    "One more time",
    "High Life",
    "Voyager",
    "Crescendolls",
    "Superheroes",
    "Face to Face"
  ];
  List<IconData> settingsIcon = [
    Icons.account_circle_rounded,
    Icons.agriculture_rounded,
    Icons.favorite_border,
    Icons.light_mode_outlined,
    Icons.remove_red_eye,
    Icons.self_improvement,
  ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: settingsConditions.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: ListTile(
          leading: Icon(settingsIcon[index]),
          title: Text(settingsString[index]),
          trailing: buildSwitchButton(Colors.green, Colors.red, index),
        ));
      },
    )));
  }

  //don't work because the val variable don't change when setState
  Widget buildSwitchButton(colorOn, colorOff, val) => Transform.scale(
      scale: 1,
      child: Switch.adaptive(
          activeColor: colorOn,
          activeTrackColor: colorOn.withOpacity(0.4),
          inactiveThumbColor: colorOff,
          inactiveTrackColor: colorOff.withOpacity(0.3),
          value: settingsConditions[val],
          onChanged: (value) =>
              setState(() => settingsConditions[val] = value)));
}
