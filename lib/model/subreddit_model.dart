import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/controller/search_controller.dart';
import '../widgets/feed.dart';
import '../controller/subreddit_controller.dart';

class SubredditModel {
  late String subredditName = "";
  late String subredditImgUrl = "";
  late String description = "";
  late int subscribers = 0;
  late String headerUrl = "";

  SubredditModel(this.subredditName, this.subredditImgUrl, this.description,
      this.subscribers, this.headerUrl);
}

class SubredditFeed {
  late List<SubredditModel> subreddits = [];

  Future<bool> setInfo(String query) async {
    String postsList = await SearchController.GetSubreddits(query);
    String iconImg = "";

    print("QUERY: " + query);
    if (postsList == "") {
      return false;
    }
    var jsonPosts = jsonDecode(postsList);
    print("JSON: " + jsonPosts.toString());
    var data = jsonPosts['data'];
    List actualPosts = data['children'];
    //var firstPost = actualPosts[0]["data"];

    for (var i = 0; i < actualPosts.length; i++) {
      var postData = actualPosts[i]['data'];

      String? headerUrl = postData['header_img'];

      // if null, assign to ""
      headerUrl ??= "";

      if (postData['icon_img'] == null) {
        iconImg = "";
      }
      SubredditModel newSubreddit = SubredditModel(
          postData['title'],
          iconImg,
          postData['public_description'],
          postData['subscribers'],
          headerUrl);
      subreddits.add(newSubreddit);
    }
    //print("POST 1 : " + firstPost['title']);
    return (true);
  }

  List<Widget> getFeed() {
    List<Widget> postWidgets = [];

    for (var i = 0; i < subreddits.length; i++) {
      postWidgets.add(subredditRow(
          subreddits[i].subredditImgUrl, subreddits[i].subredditName));
    }
    return (postWidgets);
  }

  Future<List<SubredditModel>> getSubredditsFromStream(
      Stream<Subreddit> subStream) async {
    await for (final value in subStream) {
      var jsonVal = jsonDecode(value.toString());
      //print(jsonVal['header_img']);

      String? headerUrl = jsonVal['header_img'];

      // if null, assign to ""
      headerUrl ??= "";

      SubredditModel newSubModel = SubredditModel(
          jsonVal['title'],
          jsonVal['icon_img'],
          jsonVal['public_description'],
          jsonVal['subscribers'],
          headerUrl);

      subreddits.add(newSubModel);
      //print(value.title);
    }
    return (subreddits);
  }

  Future<bool> setMyInfo() async {
    // subredditController
    Stream<Subreddit> subredditStream = SubredditController.GetData();

    await getSubredditsFromStream(subredditStream);

    //print("subreddits property " + rawJSON['subreddit'].toString());

    return (true);
  }

  List<Widget> getMySubreddits() {
    List<Widget> subredditWidgets = [];

    for (var i = 0; i < subreddits.length; i++) {
      subredditWidgets.add(subredditRow(
          subreddits[i].subredditImgUrl, subreddits[i].subredditName));
    }
    return (subredditWidgets);
  }
}
