import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class RedditWrapper {
  static ExampleAPICall() async {
    // API endpoint
    var url = Uri.parse('https://www.reddit.com/hot.json');

    var response = await http.get(url);

    // json in response.body
    print(response.body);
  }


  // ?limit=x to control list length
  static Future<String> GetDefaultPosts(String filter) async {
    // API endpoint

    var url = Uri.parse('https://www.reddit.com/' + filter + '.json');

    var response = await http.get(url);
    return (response.body);
  }

  static Future<String> GetSubreddits(String filter) async {
    // API endpoint

    var url = Uri.parse('https://www.reddit.com/subreddits/search.json?q=' + filter);

    var response = await http.get(url);
    return (response.body);
  }
}
