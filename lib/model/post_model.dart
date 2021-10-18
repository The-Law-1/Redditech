import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/controller/post_controller.dart';
import '../controller/profile_controller.dart';

// post modelclass
class Post {
  late String subredditName = "";
  late String authorName = "";
  late String thumbnail = "";
  late String postHeader = "";
  late List<String> previewImages = [];
  late String textContent = "";

  Post(this.subredditName, this.authorName, this.thumbnail, this.postHeader,
      this.previewImages, this.textContent) {
    // do operations on preview images to only get the jpeg
  }
}

class PostFeed {
  late List<Post> posts = [];
  late String preference = "hot";

  Future<bool> setInfo(String newPref) async {
    preference = newPref;

    String postsList = await PostController.GetDefaultPosts(newPref);

    // json decode
    var jsonPosts = jsonDecode(postsList);
    var data = jsonPosts["data"];
    List actualPosts = data["children"];

    /*var postData = actualPosts[0]["data"];
    List<String> imageUrls = [];

    print(postData["preview"].toString());
    //imageUrls.add(postData["preview"]["images"][0]["source"]["url"]);

    Post newPost = Post(postData['subreddit'], postData['author_fullname'],
        postData['thumbnail'], postData['title'], imageUrls, postData['selftext']);*/

    for (var i = 0; i < actualPosts.length; i++) {
      var postData = actualPosts[i]["data"];

      try {
        print(postData["preview"]["images"][0]["source"]["url"].toString());
      } catch (e) {
        print("No preview");
      }

      //print(actualPosts[i].toString());
    }
    // loop over children
    // inform posts list as should be done

    return (true);
  }

  List<Widget> GetFeed() {
    List<Widget> postWidgets = [];

    return (postWidgets);
  }
}
