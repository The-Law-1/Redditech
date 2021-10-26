import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/controller/search_controller.dart';
import '../widgets/feed.dart';
import '../controller/subreddit_controller.dart';
import '../model/post_model.dart';

class SubredditModel {
  late String subredditName = "";
  late String subredditImgUrl = "";
  late String description = "";
  late int subscribers = 0;
  late String headerUrl = "";

  late List<Post> postFeed;

  SubredditModel(this.subredditName, this.subredditImgUrl, this.description,
      this.subscribers, this.headerUrl);
}

class SubredditFeed {
  late List<SubredditModel> subreddits = [];
  late BuildContext context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  Future<bool> setInfo(String query) async {
    subreddits = [];

    String postsList = await SearchController.GetSubreddits(query);
    String iconImg = "";

    print("QUERY: " + query);
    if (postsList == "") {
      return false;
    }
    var jsonPosts = jsonDecode(postsList);
    //print("JSON: " + jsonPosts.toString());
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
      } else {
        iconImg = postData['icon_img'];
      }
      int? subs = postData['subscribers'];

      subs ??= 0;

      SubredditModel newSubreddit = SubredditModel(postData['title'], iconImg,
          postData['public_description'], subs, headerUrl);
      subreddits.add(newSubreddit);
    }
    //print("POST 1 : " + firstPost['title']);
    return (true);
  }

  List<Widget> getFeed() {
    List<Widget> postWidgets = [];

    for (var i = 0; i < subreddits.length; i++) {
      postWidgets.add(subredditFeedItem(subreddits[i], context));
    }
    return (postWidgets);
  }

  Future<List<SubredditModel>> getSubredditsFromStream(
      Stream<Subreddit> subStream) async {
    subreddits = [];

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

      if (newSubModel.subredditName.startsWith("r/")) {
        newSubModel.subredditName =
            newSubModel.subredditName.replaceFirst("r/", "");
      }
      if (newSubModel.subredditName.startsWith("/r/")) {
        newSubModel.subredditName =
            newSubModel.subredditName.replaceFirst("/r/", "");
      }

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
      subredditWidgets.add(subredditFeedItem(subreddits[i], context));
    }
    return (subredditWidgets);
  }
}
