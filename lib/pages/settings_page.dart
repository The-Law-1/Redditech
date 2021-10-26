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

  bool connected = false;
  bool infoSet = false;

  void querySettingsAPI() async {
    print("Waiting for settings...");

    connected = await RedditInfo.isConnected();
    if (connected) {
      if (infoSet == false) {
        print("checkpoint");
        var result =
            await RedditInfo.red.get("api/v1/me/prefs", objectify: false);

        //RedditInfo.red.
        //'https://oauth.reddit.com/api/v1/me/prefs' -X PATCH -d '{"lang": "en-us"}'

        result['over_18'] = true;
        print("Prefs result " + result.toString());
        setState(() {
          infoSet = true;
          settingsElements = [];
          settingsElements.add(
              simpleButton(result['over_18'], "Over 18", Icons.block_outlined));
        });
      }
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
      padding: const EdgeInsets.only(top: 100),

      children: settingsElements,
    )));
  }

  Widget simpleButton(value, text, icon) {
    return ListTile(
      leading: Icon(icon, size: 40, color: value ? Colors.green : Colors.grey),
      title: Text(text,
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
      trailing: buildSwitchButton(Colors.green, Colors.grey, value),
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
          value: val,
          onChanged: (value) => setState(() {
              })));

  /*Widget buildDropdownButton(BuildContext context, val) {
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
  }*/
}
