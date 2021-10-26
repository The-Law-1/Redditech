import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/controller/reddit_wrapper.dart';

class PostController {
  static Future<String> GetDefaultPosts(String filter) async {
    return (await RedditWrapper.GetDefaultPosts(filter));
  }

  static Future<String> getSubredditPosts(
      String filter, String subredditName) async {
    return (await RedditWrapper.getSubredditPosts(filter, subredditName));
  }
}
