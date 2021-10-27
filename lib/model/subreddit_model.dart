import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/controller/search_controller.dart';
import '../widgets/feed.dart';
import '../controller/subreddit_controller.dart';
import '../model/post_model.dart';
import 'package:draw/src/api_paths.dart';

class SubredditModel {
  late String subredditName = "";
  late String subredditImgUrl = "";
  late String description = "";
  late int subscribers = 0;
  late String headerUrl = "";

  late List<Post> postFeed;
  bool isJoined = false;

  SubredditModel(this.subredditName, this.subredditImgUrl, this.description,
      this.subscribers, this.headerUrl,
      {this.isJoined = false});
}

class SubredditFeed {
  late List<SubredditModel> subreddits = [];
  late BuildContext context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  Future<bool> setInfo(String query) async {
    bool connected = await RedditInfo.isConnected();

    if (connected) {
      await setMyInfo();
    }

    List<SubredditModel> subredditList = await SubredditController.SearchSubreddits(subreddits, query);
    if (subredditList.isEmpty) {
      return (false);
    }
    // needs copy ?
    subreddits = subredditList;
    return (true);
  }

  List<Widget> getFeed() {
    List<Widget> postWidgets = [];

    for (var i = 0; i < subreddits.length; i++) {
      postWidgets.add(subredditFeedItem(subreddits[i], context));
    }
    return (postWidgets);
  }

  Future<List<SubredditModel>> getSubredditsFromStream(Stream<Subreddit> subStream) async {
    subreddits = [];

    await for (final value in subStream) {
      var jsonVal = jsonDecode(value.toString());
      String? headerUrl = jsonVal['header_img'];

      // if null, assign to ""
      headerUrl ??= "";

      SubredditModel newSubModel = SubredditModel(
          jsonVal['display_name'],
          jsonVal['icon_img'],
          jsonVal['public_description'],
          jsonVal['subscribers'],
          headerUrl,
          isJoined: true);

      subreddits.add(newSubModel);
      //print(value.title);
    }
    return (subreddits);
  }

  Future<bool> setMyInfo() async {
    // subredditController
    Stream<Subreddit> subredditStream = SubredditController.GetData();

    await getSubredditsFromStream(subredditStream);
    return (true);
  }

  List<Widget> getMySubreddits({VoidCallback faveCallback = defaultCallback}) {
    List<Widget> subredditWidgets = [];

    for (var i = 0; i < subreddits.length; i++) {
      subredditWidgets.add(subredditFeedItem(subreddits[i], context,
          faveCallback: faveCallback));
    }
    return (subredditWidgets);
  }
}

Future<void> subscribeToSubreddit(String name) async {
  if (await RedditInfo.isConnected() == false) {
    return;
  }
  final data = {
    'action': 'sub',
    'skip_initial_defaults': 'true',
    'sr_name': name //_subredditList(this, otherSubreddits),
  };

  void result = await RedditInfo.red
      .post(apiPath['subscribe'], data, discardResponse: true);

  print("Subscribed to " + name);
  globalUpdateSearchPage = true;
  return (result);
}

Future<void> unsubscribeFromSubreddit(String name) async {
  if (await RedditInfo.isConnected() == false) {
    return;
  }
  final data = {
    'action': 'unsub',
    'sr_name': name //_subredditList(this, otherSubreddits),
  };

  void result = await RedditInfo.red
      .post(apiPath['subscribe'], data, discardResponse: true);

  globalUpdateSearchPage = true;
  print("Unsubbed from " + name);
  return (result);
}
