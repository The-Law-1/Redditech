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
import 'package:redditech/pages/home_page.dart';
import 'package:redditech/pages/searching_page.dart';

void main() {
  testWidgets('Search widgets appear', (WidgetTester tester) async {
    Widget toTest = const MaterialApp(home: Scaffold(body: SearchingPage()));

    await tester.pumpWidget(toTest);

    // subslist
    expect(find.byType(ListView, skipOffstage: false), findsWidgets);
    // search bar
    expect(find.byType(FloatingSearchBar, skipOffstage: false), findsOneWidget);
  });

  testWidgets('Search query', (WidgetTester tester) async {
    Widget toTest = const MaterialApp(home: Scaffold(body: SearchingPage()));

    await tester.pumpWidget(toTest);

    await tester.tap(find.text("Search..."));
    await tester.pumpAndSettle();

    tester.testTextInput.enterText("Dog");
    await tester.testTextInput.receiveAction(TextInputAction.search);

    expect(find.text("Dog", skipOffstage: false), findsOneWidget);

    // ! can't find the list, the request won't go out
  });
}
