import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/model/subreddit_model.dart';
import '../widgets/feed.dart';

// ! https://www.youtube.com/watch?v=X95-2wES1II&ab_channel=JohannesMilke

void ExpandSubredditPage(BuildContext context, SubredditModel subreddit) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SubredditPage(subredditModel: subreddit)));
}

// takes a subreddit object with
class SubredditPage extends StatefulWidget {
  final SubredditModel subredditModel;
  const SubredditPage({Key? key, required this.subredditModel}) : super(key: key);

  @override
  _SubredditPageState createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  final double coverHeight = 280; // banner height
  final double profileHeight = 144; // profile pic height

  List<Widget> subredditElements = [];
  @override
  Widget build(BuildContext context) {
    subredditElements = [];
    subredditElements.addAll([
      buildUpperZone(
          widget.subredditModel.headerUrl,
          widget.subredditModel.subredditImgUrl),
      buildSubredditInfo(
          widget.subredditModel.subredditName, widget.subredditModel.description)
    ]);
    //subredditElements.addAll(createPostsFeed("Best"));

    return (Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: const Text(''),
      ),
      body: ListView(
      padding: EdgeInsets.zero,
      children: subredditElements,
    )));
  }

  Widget buildSubredditInfo(String subredditName, String description) => Column(
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
      backgroundImage: NetworkImage(imgUrl));

  Widget buildCoverImage(String imgUrl) => Container(
        color: Colors.grey,
        // replace .network with .asset probably ??
        child: Image.network(
          imgUrl,
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
}
