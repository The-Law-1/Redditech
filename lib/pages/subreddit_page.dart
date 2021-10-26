import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/model/subreddit_model.dart';
import '../widgets/feed.dart';
import '../model/post_model.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

// ! https://www.youtube.com/watch?v=X95-2wES1II&ab_channel=JohannesMilke

void ExpandSubredditPage(BuildContext context, SubredditModel subreddit) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SubredditPage(subredditModel: subreddit)));
}

// takes a subreddit object with
class SubredditPage extends StatefulWidget {
  final SubredditModel subredditModel;
  const SubredditPage({Key? key, required this.subredditModel})
      : super(key: key);

  @override
  _SubredditPageState createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  final double coverHeight = 280; // banner height
  final double profileHeight = 144; // profile pic height

  List<Widget> subredditElements = [];
  List<Widget> postsFeed = [];
  String currentPref = "hot";

  List<Widget> finalElements = [];

  bool initialized = false;
  PostFeed postFeed = PostFeed();

  void initialize() async {
    if (initialized) {
      return;
    }
    print("Subname " + widget.subredditModel.subredditName);

    await postFeed.setInfo(currentPref,
        subredditName: widget.subredditModel.subredditName);
    setState(() {
      subredditElements = [];
      subredditElements.addAll([
        buildUpperZone(widget.subredditModel.headerUrl,
            widget.subredditModel.subredditImgUrl),
        buildSubredditInfo(
            widget.subredditModel.subredditName,
            widget.subredditModel.description,
            widget.subredditModel.subscribers)
      ]);

      postsFeed = postFeed.getFeed();

      finalElements = [];
      finalElements.addAll(subredditElements);
      finalElements.addAll(postsFeed);

      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    //print("Final elements length " + finalElements.length.toString());

    return (Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          //title: const Text(''),
          ),
      body: ListView(padding: EdgeInsets.zero, children: finalElements),
      floatingActionButton: filterCircularMenu(),
    ));
  }

  Widget buildSubredditInfo(
          String subredditName, String description, int subs) =>
      Column(
        children: [
          const SizedBox(height: 8),
          Text(
            subredditName,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              "Subscribers: " + subs.toString(),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          )
        ],
      );

  Widget buildUpperZone(String imageUrl, String bannerUrl) {
    final bottomOffset = profileHeight / 2; // offset for text

    final topOffset = coverHeight -
        profileHeight / 2; // offset between coverHeight and profile pic

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottomOffset),
          child: buildCoverImage(imageUrl),
        ),
        Positioned(
          top: topOffset,
          child: buildSubredditImage(bannerUrl),
        )
      ],
    );
  }

  Widget buildSubredditImage(String imgUrl) => CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(imgUrl != ""
          ? imgUrl
          : "https://www.reddit.com/static/self_default2.png"));

  Widget buildCoverImage(String imgUrl) {
    // ! also check if it returns nothing ??
    return Container(
      color: Colors.grey,
      // replace .network with .asset probably ??
      child: Image.network(
        imgUrl != ""
            ? imgUrl
            : "https://somegadgetguy.com/wp-content/uploads/2014/03/reddit-banner.jpg",
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  void updatePage(String newPref) {
    setState(() {
      currentPref = newPref;
      postsFeed = postFeed.getFeed();
      finalElements = [];
      finalElements.addAll(subredditElements);
      finalElements.addAll(postsFeed);
    });
  }

  Widget filterCircularMenu() => FabCircularMenu(
          fabOpenIcon: const Icon(Icons.filter_list),
          children: <Widget>[
            IconButton(
                icon: const Icon(Icons.fireplace),
                onPressed: () async {
                  await postFeed.setInfo("hot",
                      subredditName: widget.subredditModel.subredditName);
                  updatePage("hot");
                }),
            IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () async {
                  await postFeed.setInfo("best",
                      subredditName: widget.subredditModel.subredditName);
                  updatePage("best");
                }),
            IconButton(
                icon: const Icon(Icons.flash_on),
                onPressed: () async {
                  await postFeed.setInfo("new",
                      subredditName: widget.subredditModel.subredditName);
                  updatePage("new");
                }),
          ]);
}
