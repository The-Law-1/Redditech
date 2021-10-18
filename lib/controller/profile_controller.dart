// class ProfileController
import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:redditech/controller/reddit_draw.dart';

class ProfileController {
  static Future<Redditor?> GetData() async {
    Redditor? profileInfo = await RedditInfo.red.user.me();

    return (profileInfo);
  }
}
// static function to retrieve raw info