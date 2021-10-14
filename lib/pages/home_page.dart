import 'package:flutter/material.dart';
import '../reddit_draw.dart';
import '../main.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../widgets/feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> /* with RedditInfo*/ {
  List<Widget> postsFeed = createPostsFeed("Hot");
  String dropdownValue = "Hot";

  List<Widget> homeElements = [];

  @override
  Widget build(BuildContext context) {
    homeElements.add(filtersDropDown());
    homeElements.addAll(postsFeed);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('Home'),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: homeElements,
          // tabs for HOT/BEST/NEW
          ),
          //child: ListView(padding: EdgeInsets.zero, children: postsFeed),
          // list view of posts
          // ),
        );
  }

  Widget filtersDropDown() => DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          postsFeed = createPostsFeed(dropdownValue);
        });
      },
      items: <String>['Hot', 'Best', 'New', 'Popular']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList());
}
