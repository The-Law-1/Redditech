import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        return Container(
          height: 100,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.all(5),
              shadowColor: Colors.blueGrey,
              elevation: 5,
              child: Center(
                child: ListTile(
                  leading: Icon(settingsIcon[index],
                      size: 40,
                      color:
                          settingsConditions[index] ? Colors.green : Colors.grey),
                  title: Text(settingsString[index],
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 2.0)),
                  trailing: buildSwitchButton(Colors.green, Colors.grey, index),
                ),
              )),
        );
      },
    )));
  }

  //don't work because the val variable don't change when setState
  Widget buildSwitchButton(colorOn, colorOff, val) => Transform.scale(
      scale: 1.5,
      child: Switch.adaptive(
          activeColor: colorOn,
          activeTrackColor: colorOn.withOpacity(0.4),
          inactiveThumbColor: colorOff,
          inactiveTrackColor: colorOff.withOpacity(0.3),
          value: settingsConditions[val],
          onChanged: (value) =>
              setState(() => settingsConditions[val] = value)));
}
