import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/controller/post_controller.dart';
import '../controller/profile_controller.dart';
import '../widgets/feed.dart';

// ! move logic to controller

// post modelclass
class Post {
  late String subredditName = "";
  late String subredditImgUrl = "";

  late String authorName = "";
  late String thumbnail = "";
  late String postHeader = "";
  late List<String> previewImages = [];
  late String textContent = "";

  Post(this.subredditName, this.authorName, this.thumbnail, this.postHeader,
      this.previewImages, this.textContent) {
    // do operations on preview images to only get the jpeg

    for (var i = 0; i < previewImages.length; i++) {
      try {
        previewImages[i] = previewImages[i].substring(
            0, previewImages[i].indexOf('?')); // ! could be unstable/dangerous
      } catch (e) {
        print(e);
      }
    }
  }
}

class PostFeed {
  late List<Post> posts = [];
  late String preference = "hot";

  Future<bool> setInfo(String newPref, {String subredditName = ""}) async {
    posts = [];
    preference = newPref;

    String postsList = "";

    if (subredditName == "") {
      postsList = await PostController.GetDefaultPosts(newPref);
    } else {
      postsList =
          await PostController.getSubredditPosts(newPref, subredditName);
    }

    // json decode
    var jsonPosts = jsonDecode(postsList);

    var data = jsonPosts["data"];
    List actualPosts = data["children"];

    for (var i = 0; i < actualPosts.length; i++) {
      var postData = actualPosts[i]["data"];
      List<String> previewImages = [];

      try {
        // ! there can be more than one source, check in "variants" object of images
        //print(postData["preview"]["images"][0]["source"]["url"].toString());
        previewImages
            .add(postData["preview"]["images"][0]["source"]["url"].toString());
      } catch (e) {
      }

      String authorName = "";
      try {
        authorName = postData['author_fullname'];
      } catch (e) {
        authorName = "";
      }

      Post newPost = Post(
          postData['subreddit'],
          authorName,
          postData['thumbnail'],
          postData['title'],
          previewImages,
          postData['selftext']);

      posts.add(newPost);
    }

    return (true);
  }

  List<Widget> getFeed() {
    List<Widget> postWidgets = [];

    for (var i = 0; i < posts.length; i++) {
      postWidgets.add(buildPostFeedContainerFromPost(posts[i]));
    }
    return (postWidgets);
  }
}
