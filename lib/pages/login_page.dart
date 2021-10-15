import 'package:flutter/material.dart';
import '../controller/reddit_draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class LoginPage extends StatelessWidget /* with RedditInfo*/ {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Login'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          const OutlinedButton(
              onPressed: RedditInfo.sayHi, child: Text('SayHi')),
          OutlinedButton(
              onPressed: () async {
                RedditInfo.connection();
              },
              child: const Text('Connect'))
        ],
      )),
    );
  }
}
