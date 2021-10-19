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
  List<Widget> postsFeed = [];
  String currentPref = "hot";

  bool initialized = false;
  PostFeed postFeed = PostFeed();

  void Initialize() async {
    if (initialized) {
      return;
    }
    await postFeed.setInfo(currentPref);
    setState(() {
      postsFeed = postFeed.getFeed();
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // needs await here
    Initialize();

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
                onPressed: () async {
                  await postFeed.setInfo("hot");
                  setState(() {
                    currentPref = "hot";
                    postsFeed = postFeed.getFeed();
                  });
                }),
            IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () async {
                  await postFeed.setInfo("best");
                  setState(() {
                    currentPref = "best";
                    postsFeed = postFeed.getFeed();
                  });
                }),
            IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () async {
                  await postFeed.setInfo("new");
                  print("Filter: NEW " + postFeed.posts[0].postHeader);
                  setState(() {
                    currentPref = "new";
                    postsFeed = postFeed.getFeed();
                  });
                }),
          ]);
}
