import 'package:flutter/material.dart';
import 'package:redditech/pages/home_page.dart';
import 'package:redditech/pages/post_page.dart';
import 'package:redditech/pages/profile_page.dart';
import 'package:redditech/pages/searching_page.dart';
import 'package:redditech/pages/settings_page.dart';
import 'package:redditech/pages/subreddit_page.dart';

//https://www.youtube.com/watch?v=xoKqQjSDZ60&ab_channel=JohannesMilke

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redditech',
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
  int currentIndex = 0;
  String queryResult = "";

  final List<StatefulWidget> screens = [
    const HomePage(),
    const SearchingPage(),
    const SettingsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        // todo transformer en widget ceci

        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.red,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 40,
            // selectedFontSize: 25,
            // unselectedFontSize: 16,
            //showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                if (currentIndex == 1) {
                  print("Change page to search");
                  screens[currentIndex] = SearchingPage();
                }
                if (currentIndex == 2) {
                  screens[currentIndex] = SettingsPage();
                }
                if (currentIndex == 3) {
                  screens[currentIndex] = ProfilePage();
                }
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Browse',
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
