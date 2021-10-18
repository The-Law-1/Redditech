import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../controller/profile_controller.dart';

// profile modelclass
class ProfileModel {
  late String userName = "";
  late String description = "";
  late String profilePicUrl = "";

  Future<bool> setInfo() async {
    Redditor? rawInfo = await ProfileController.GetData();

    if (rawInfo != null) {
      print("Got user " + rawInfo.toString());

      userName = rawInfo.displayName;
      print("Got name " + userName);
      // description = rawInfo.subreddit.description;
      // profilePicUrl = rawInfo.subreddit.icon_img;
      return (true);
    }
    return (false);
  }
}
