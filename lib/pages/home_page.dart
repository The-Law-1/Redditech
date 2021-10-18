import 'package:flutter/material.dart';
import 'package:redditech/model/post_model.dart';
import '../controller/reddit_draw.dart';
import '../main.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import '../widgets/feed.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

//import 'package:speed_dial/speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> /* with RedditInfo*/ {
  List<Widget> postsFeed = createPostsFeed("hot");
  String currentPref = "hot";

  PostFeed postFeed = PostFeed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Home'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: postsFeed,
        // tabs for HOT/BEST/NEW
      ),
      floatingActionButton: filterCircularMenu(),
      //child: ListView(padding: EdgeInsets.zero, children: postsFeed),
      // list view of posts
      // ),
    );
  }

  //https://pub.dev/packages/fab_circular_menu
  Widget filterCircularMenu() => FabCircularMenu(
          fabOpenIcon: const Icon(Icons.filter_list),
          children: <Widget>[
            IconButton(
                icon: const Icon(Icons.fireplace),
                onPressed: () => setState(() {
                      currentPref = "hot";
                      postsFeed = createPostsFeed("hot");
                      postFeed.setInfo(currentPref);
                    })),
            IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () => setState(() {
                      currentPref = "best";
                      postsFeed = createPostsFeed("best");
                      postFeed.setInfo(currentPref);
                    })),
            IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () => setState(() {
                      currentPref = "new";
                      postsFeed = createPostsFeed("new");
                      postFeed.setInfo(currentPref);
                    })),
          ]);
}
