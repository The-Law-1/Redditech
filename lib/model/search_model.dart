import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redditech/controller/search_controller.dart';
import '../widgets/feed.dart';

class SubredditModel {
  late String subredditName = "";
  late String subredditImgUrl = "";
  late String textContent = "";

  SubredditModel(this.subredditName, this.subredditImgUrl, this.textContent);
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

      if (postData['icon_img'] == null) {
        iconImg = "";
      }
      SubredditModel newSubreddit = SubredditModel(
          postData['title'], iconImg, postData['public_description']);
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
}
