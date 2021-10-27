// class ProfileController
import 'dart:convert';
import 'package:redditech/controller/search_controller.dart';
import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/model/subreddit_model.dart';

class SubredditController {
  static Stream<Subreddit> GetData() {
    Stream<Subreddit>? subreddits = RedditInfo.red.user.subreddits();

    return (subreddits);
  }

  static bool subredditsContainsName(List<SubredditModel> subsList, String subName) {
    for (var i = 0; i < subsList.length; i++) {
      if (subsList[i].subredditName == subName) {
        print("You are subscribed to " + subName);
        return (true);
      }
    }
    return (false);
  }


  static Future<List<SubredditModel>> SearchSubreddits(List<SubredditModel> joinedSubs, String query) async
  {
    String postsList = await SearchController.GetSubreddits(query);
    String iconImg = "";

    List<SubredditModel> subredditList = [];

    print("QUERY: " + query);
    if (postsList == "") {
      return [];
    }
    var jsonPosts = jsonDecode(postsList);
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

      bool joined = false;
      if (joinedSubs.isNotEmpty) {
        joined = subredditsContainsName(joinedSubs, postData['display_name']);
      }

      SubredditModel newSubreddit = SubredditModel(postData['display_name'],
          iconImg, postData['public_description'], subs, headerUrl,
          isJoined: joined);
      subredditList.add(newSubreddit);
    }

    return (subredditList);
  }
}
// static function to retrieve raw info