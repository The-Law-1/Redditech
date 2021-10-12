import 'dart:async';
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

abstract class RedditInfo {
  //factory RedditInfo_() => null;

  var red = Reddit.createInstalledFlowInstance(
    clientId: "MMGIkAwcebtbAJ4IOEGV4A",
    userAgent: "Appdev",
    redirectUri: Uri.parse("tol://localhost"),
  );

  void sayHi() {
    print("Hi");
  }

  Future<String> _connectToReddit(red) async {
    final authUrl = red.auth.url(["*"], "Appdev", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(), callbackUrlScheme: "tol");

    String? code = Uri.parse(result).queryParameters['code']; // pourquoi 'code'

    await red.auth.authorize(code.toString());

    //Redditor? me = await red.user.me();

    return (red.toString());
    //return (red);
  }

  void connection() async {
    try {
      await red.user.me();
      //print("Before connection " + (await red.user.me()).toString());
      print("Client connected");
    } catch (e) {
      print("Client not connected: " + e.toString());

      // vérifier si red est déja authentifié
      await _connectToReddit(red);
      print("After connection " + (await red.user.me()).toString());
    }
  }
}
