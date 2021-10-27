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

    List<dynamic> postsList = [];

    if (subredditName == "") {
      postsList = await PostController.GetDefaultPosts(newPref);
    } else {
      postsList =
          await PostController.getSubredditPosts(newPref, subredditName);
    }

    for (var post in postsList) {
      //print("New post item " + post["data"]["preview_images"].toString());

      var postData = post["data"];

      Post newPost = Post(
          postData['subreddit'],
          postData["author_fullname"],
          postData['thumbnail'],
          postData['title'],
          postData["preview_images"],
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
