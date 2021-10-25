import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/model/subreddit_model.dart';
import '../widgets/feed.dart';

// ! https://www.youtube.com/watch?v=X95-2wES1II&ab_channel=JohannesMilke

void ExpandSubredditPage(BuildContext context, SubredditModel subreddit) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SubredditPage()));
}

// takes a subreddit object with
class SubredditPage extends StatefulWidget {
  const SubredditPage({Key? key}) : super(key: key);

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
          "https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80",
          'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
      buildSubredditInfo(
          "Hacking", "A subreddit dedicated to hacking and hackers")
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
