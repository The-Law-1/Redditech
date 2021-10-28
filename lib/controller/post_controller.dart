import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/controller/reddit_wrapper.dart';

class PostController {
  static Future<List> GetDefaultPosts(String filter) async {
    String rawPosts = await RedditWrapper.GetDefaultPosts(filter);

    List posts = refinePostData(rawPosts);

    return (posts);
  }

  static List refinePostData(String rawPosts) {
    if (rawPosts == "") return ([]);

    var jsonPosts = jsonDecode(rawPosts);

    List posts = jsonPosts["data"]["children"];

    for (var i = 0; i < posts.length; i++) {
      var postData = posts[i]["data"];
      List<String> previewImages = [];

      try {
        // ! there can be more than one source, check in "variants" object of images
        //print(postData["preview"]["images"][0]["source"]["url"].toString());
        previewImages
            .add(postData["preview"]["images"][0]["source"]["url"].toString());
      } catch (e) {
        //print("Caught error " + e.toString());
      }

      String authorName = "";
      try {
        authorName = postData['author_fullname'];
      } catch (e) {
        authorName = "";
      }

      // ! if key doesn't exist what happens
      postData['author_fullname'] = authorName;

      // ! same here can we just add this ? And as a list too ?
      postData['preview_images'] = previewImages;
      posts[i]["data"] = postData;
    }
    return (posts);
  }

  static Future<List> getSubredditPosts(
      String filter, String subredditName) async {
    String rawPosts =
        await RedditWrapper.getSubredditPosts(filter, subredditName);

    List refinedPostData = refinePostData(rawPosts);

    return (refinedPostData);
  }
}
