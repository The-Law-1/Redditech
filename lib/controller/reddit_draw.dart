import 'dart:async';
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

// repository (design pattern)
// model user
// home, profile, subreddits, etC...
// controller fills out models

// COLOR THEME
// home without login
// github projects
// documentation
// CI
// functional/controller tests
// research block architectureP

class RedditInfo {
  //factory RedditInfo_() => null;

  static var red = Reddit.createInstalledFlowInstance(
    clientId: "MMGIkAwcebtbAJ4IOEGV4A",
    userAgent: "Appdev",
    redirectUri: Uri.parse("tol://localhost"),
  );

  static void sayHi() {
    print("Hi");
  }

  static Future<String> _connectToReddit(red) async {
    final authUrl = red.auth.url(["*"], "Appdev", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(), callbackUrlScheme: "tol");

    String? code = Uri.parse(result).queryParameters['code']; // pourquoi 'code'

    await red.auth.authorize(code.toString());

    //Redditor? me = await red.user.me();

    return (red.toString());
    //return (red);
  }

  static Future<bool> connection() async {
    try {
      await red.user.me();
      //print("Before connection " + (await red.user.me()).toString());
      print("Client connected");
      return (true);
    } catch (e) {
      print("Client not connected: " + e.toString());
      await _connectToReddit(red);
      return (false);
    }
  }
}
