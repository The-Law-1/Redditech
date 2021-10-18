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
  List<List <String>> parameters = [
    ['One', 'Two', 'Free', 'Four'],
    ['Un', 'Deux', 'Trois', 'Quatre']
  ];
  List<String> dropdownValue = [
      'One',
      'Un',
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
                        color: settingsConditions[index]
                            ? Colors.green
                            : Colors.grey),
                    title: Text(settingsString[index],
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.0)),
                    trailing: index < 5
                        ? buildSwitchButton(Colors.green, Colors.grey, index)
                        : buildDropdownButton(context, index)),
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

  Widget buildDropdownButton(BuildContext context, val) {
    return DropdownButton<String>(
      value: dropdownValue[val-5],
      icon: const Icon(Icons.arrow_downward),
      iconSize: 42,
      //elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 24),
      /*underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),*/
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue[val-5] = newValue!;
        });
      },
      items: parameters[val-5]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
