import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/controller/reddit_wrapper.dart';

class SearchController {
  static Future<String> GetSubreddits(String filter) async {
    return (await RedditWrapper.GetSubreddits(filter));
  }
}