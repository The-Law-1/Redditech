import 'dart:convert';
import 'package:http/http.dart' as http;
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

  var result;
  bool connected = false;
  bool infoSet = false;

  void updateButtons() {
    setState(() {
      settingsElements = [];
      settingsElements.addAll([
        simpleButton(result, "over_18", "Over 18", Icons.block_outlined),
        simpleButton(result, "email_messages", "Email Messages", Icons.mail),
        simpleButton(
            result, "show_presence", "Show Presence", Icons.remove_red_eye),
        simpleButton(
            result, "no_profanity", "No profanity", Icons.outlet_rounded),
        simpleButton(result, "video_autoplay", "Video Autoplay",
            Icons.play_arrow_rounded),
        simpleButton(result, "clickgadget", "Clickgadget", Icons.mouse_rounded),
      ]);
    });
  }

  void querySettingsAPI() async {
    print("Waiting for settings...");

    connected = await RedditInfo.isConnected();
    if (connected) {
      if (infoSet == false) {
        print("checkpoint");
        result = await RedditInfo.red.get("api/v1/me/prefs", objectify: false);

        //RedditInfo.red.
        //'https://oauth.reddit.com/api/v1/me/prefs' -X PATCH -d '{"lang": "en-us"}'

        print("Prefs result " + result.toString());
        setState(() {
          infoSet = true;
          settingsElements = [];
          settingsElements.addAll([
            simpleButton(result, "over_18", "Over 18", Icons.block_outlined),
            simpleButton(
                result, "email_messages", "Email Messages", Icons.mail),
            simpleButton(
                result, "show_presence", "Show Presence", Icons.remove_red_eye),
            simpleButton(
                result, "no_profanity", "No profanity", Icons.outlet_rounded),
            simpleButton(result, "video_autoplay", "Video Autoplay",
                Icons.play_arrow_rounded),
            simpleButton(
                result, "clickgadget", "Clickgadget", Icons.mouse_rounded),
          ]);
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
    final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];

    querySettingsAPI();

    return (Scaffold(
        body: ListView.separated(
      padding: const EdgeInsets.fromLTRB(10.0, 80.0, 10.0, 0),
      itemCount: settingsElements.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return settingsElements[index];
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.red[colorCodes[index]],
          thickness: 1,
          indent: 100,
          endIndent: 100,
        );
      },
    )));
    /*(padding: const EdgeInsets.only(top: 100),
      children: settingsElements,*/
  }

  Widget simpleButton(result, value, text, icon) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      contentPadding: const EdgeInsets.all(8.0),
      tileColor: Colors.grey[200],
      leading: Icon(icon,
          size: 40, color: result[value] ? Colors.green : Colors.grey),
      title: Container(
        alignment: Alignment.topCenter,
        child: Text(text,
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
      ),
      subtitle: Container(
        alignment: Alignment.bottomCenter,
        child: Text(result[value].toString(),
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.8)),
      ),
      trailing: buildSwitchButton(Colors.green, Colors.grey, result, value),
    );
  }

  Future<dynamic> save() async {
    var res = await http.patch(Uri.https("oauth.reddit.com", "api/v1/me/prefs"),
        headers: {
          "Authorization":
              "Bearer ${RedditInfo.red.auth.credentials.accessToken}",
          "Content-Type": "application/json"
        },
        body: json.encode(result));
    return res;
  }

  //don't work because the val variable don't change when setState
  Widget buildSwitchButton(colorOn, colorOff, result, val) => Transform.scale(
      scale: 1.5,
      child: Switch.adaptive(
          activeColor: colorOn,
          activeTrackColor: colorOn.withOpacity(0.4),
          inactiveThumbColor: colorOff,
          inactiveTrackColor: colorOff.withOpacity(0.3),
          value: result[val],
          onChanged: (value) async {
            setState(() {
              result[val] = value;
            });
            updateButtons();
            await save();
          }));

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
