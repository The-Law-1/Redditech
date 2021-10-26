import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/controller/reddit_wrapper.dart';

class PostController {
  static Future<String> GetDefaultPosts(String filter) async {
    return (await RedditWrapper.GetDefaultPosts(filter));
  }

  static Future<String> GetSubredditPosts(String filter, String subredditName) async {
    return (await RedditWrapper.GetSubredditPosts(filter, subredditName));
  }
}
