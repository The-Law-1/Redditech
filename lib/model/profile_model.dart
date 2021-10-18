import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../controller/profile_controller.dart';

// profile modelclass
class ProfileModel {
  late String userName = "";
  late String description = "";
  late String profilePicUrl = "";
  late String bannerPicUrl = "";

  Future<bool> setInfo() async {
    Redditor? rawInfo = await ProfileController.GetData();

    if (rawInfo != null) {
      var rawJSON = jsonDecode(rawInfo.toString());

      print("subreddits property " + rawJSON['subreddit'].toString());

      userName = rawJSON['subreddit']['title'];
      description = rawJSON['subreddit']['public_description'];

      profilePicUrl = rawJSON['subreddit']['icon_img'];

      profilePicUrl = profilePicUrl.substring(0, profilePicUrl.indexOf('?')); // ! could be unstable/dangerous

      try {
        bannerPicUrl = rawJSON['subreddit']['banner_img'];
        bannerPicUrl = bannerPicUrl.substring(0, bannerPicUrl.indexOf('?')); // ! could be unstable/dangerous

        // cut off after .jpg
      } catch (e) {
        print(e);
      }

      print("Got name " + userName);
      // description = rawInfo.subreddit.description;
      // profilePicUrl = rawInfo.subreddit.icon_img;
      return (true);
    }
    return (false);
  }
}
