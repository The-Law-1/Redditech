import 'package:flutter/material.dart';
import '../reddit_draw.dart';
import '../main.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class HomePage extends StatelessWidget with RedditInfo {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Home'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          OutlinedButton(onPressed: sayHi, child: const Text('SayHi')),
          OutlinedButton(
              onPressed: () async {
                connection();
              },
              child: const Text('Connect'))
        ],
      )),
    );
  }
}
