import 'package:flutter/material.dart';
import '../reddit_draw.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(children: const <Widget>[
          TextButton(
            onPressed: RedditInfo.SayHi,
             child: const Text('Home')),
        ],
        )
      ),
    );
  }
}
