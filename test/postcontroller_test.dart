// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redditech/controller/post_controller.dart';
import 'package:redditech/pages/home_page.dart';
import 'package:redditech/pages/searching_page.dart';

void main() {
  test('test get posts', () async {
    List posts = await PostController.GetDefaultPosts("hot");
    assert(posts.isNotEmpty);
  });

  test('test invalid filter', () async {
    List posts =
        await PostController.GetDefaultPosts("cdqevdsnjvsdikvnsdjkvnsdjkq");
    assert(posts.isEmpty);
  });

  test('test get subreddit posts', () async {
    List posts = await PostController.getSubredditPosts("hot", "funny");
    assert(posts.isNotEmpty);
  });

  test('test invalid subreddit name', () async {
    List posts =
        await PostController.getSubredditPosts("hot", "sdnjhkcdjkcndsjkcn");
    assert(posts.isEmpty);
  });
}
