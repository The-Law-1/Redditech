import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redditech/controller/reddit_draw.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Widget> settingsElements = [];
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
  List<List<String>> parameters = [
    ['One', 'Two', 'Free', 'Four'],
    ['Un', 'Deux', 'Trois', 'Quatre']
  ];
  List<String> dropdownValue = [
    'One',
    'Un',
  ];

  bool connected = false;

  void querySettingsAPI() async {
    print("Waiting for settings...");

    connected = await RedditInfo.isConnected();
    if (connected) {
      var result = await RedditInfo.red.get("api/v1/me/prefs");

      print("Prefs result " + result);
      setState(() {
        settingsElements = [];
        settingsElements.add(simpleButton(0));
      });
    } else {
      print("Connect yo self");
    }
  }
  // ! how do we change the settings ?
  // ! I guess .post (data)
  // ! CF : https://www.reddit.com/dev/api/#GET_api_v1_me

  @override
  Widget build(BuildContext context) {
    // todo function: (cf profile page)
    // * if connected, show settings
    // * else show button to log in
    querySettingsAPI();

    return (Scaffold(
        body: ListView(
      //padding: EdgeInsets.zero,
      padding: connected ? EdgeInsets.zero : const EdgeInsets.only(top: 100),

      children: settingsElements,
    )));
  
    /*return (Scaffold(      
        body: ListView.separated(
      padding: const EdgeInsets.only(top: 70),
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
    )));*/
  }

  Widget simpleButton(value) {
    return ListTile(
      leading: Icon(Icons.remove_red_eye,
          size: 40, color: value ? Colors.green : Colors.grey),
      title: Text("button",
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
      trailing: buildSwitchButton(Colors.green, Colors.grey, 0),
    );
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
      value: dropdownValue[val - 5],
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
          dropdownValue[val - 5] = newValue!;
        });
      },
      items: parameters[val - 5].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
