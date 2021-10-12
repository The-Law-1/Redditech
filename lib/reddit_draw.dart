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

  void _connectToReddit(red) async {
    final authUrl = red.auth.url(["*"], "Appdev", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(), callbackUrlScheme: "tol");

    String? code = Uri.parse(result).queryParameters['code']; // pourquoi 'code'

    await red.auth.authorize(code.toString());

    //Redditor? me = await red.user.me();

    //return (red);
  }

  void connection() async {

    // vérifier si red est déja authentifié
    _connectToReddit(red);
  }
}
