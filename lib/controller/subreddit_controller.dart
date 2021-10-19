// class ProfileController
import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';

class SubredditController {
  static Stream<Subreddit> GetData() {
    Stream<Subreddit>? subreddits = RedditInfo.red.user.subreddits();

    return (subreddits);
  }
}
// static function to retrieve raw info