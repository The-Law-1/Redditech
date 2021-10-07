import 'package:flutter/material.dart';
import 'dart:async';
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:redditech/pages/home_page.dart';
import 'package:redditech/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String queryResult = "";
  int currentIndex = 0;

  final screens = [
    HomePage(),
    Center(child: Text('Messages', style: TextStyle(fontSize: 60))),
    Center(child: Text('Settings', style: TextStyle(fontSize: 60))),
    ProfilePage(),
  ];

  var red = Reddit.createInstalledFlowInstance(
    clientId: "MMGIkAwcebtbAJ4IOEGV4A",
    userAgent: "Appdev",
    redirectUri: Uri.parse("tol://localhost"),
  );

  void _connectToReddit() async {
    final authUrl = red.auth.url(["*"], "Appdev", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(), callbackUrlScheme: "tol");

    String? code = Uri.parse(result).queryParameters['code']; // pourquoi 'code'

    await red.auth.authorize(code.toString());

    Redditor? me = await red.user.me();

    setState(() {
      if (me != null) {
        print(me);
        queryResult = me.displayName;
      }
      // remplacer counter par une string et afficher ce dernier
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                queryResult,
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: () {
                  _connectToReddit();
                },
                child: const Text('Connect to Reddit'),
              ),
              screens[currentIndex],
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 40,
            // selectedFontSize: 25,
            // unselectedFontSize: 16,
            //showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: 'Messages',
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.orange)
            ]));
  }
}
