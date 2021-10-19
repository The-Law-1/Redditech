import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/controller/search_controller.dart';
import '../widgets/feed.dart';

class Subreddit {
  late String subredditName = "";
  late String subredditImgUrl = "";
  late String textContent = "";
}

class SubredditFeed {
  late List<Subreddit> subreddits = [];

  Future<bool> setInfo(String query) async {
    String postsList = await SearchController.GetSubreddits(query);

    var jsonPosts = jsonDecode(postsList);
    var data = jsonPosts["data"];
    List actualPosts = data["children"];
    var firstPost = actualPosts[0]["data"];
    var secPost = actualPosts[1]["data"];
    var thirdPost = actualPosts[2]["data"];

    print("POST 1 : " + firstPost['title']);
    print("POST 2 : " + secPost['title']);
    print("POST 3 : " + thirdPost['title']);
    return (true);
  }
}
