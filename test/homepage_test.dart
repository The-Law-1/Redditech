// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:redditech/main.dart';
import 'package:redditech/pages/home_page.dart';
import 'package:redditech/pages/searching_page.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('Home widgets appear', (WidgetTester tester) async {
    Widget toTest =
        const MaterialApp(home: const Scaffold(body: const HomePage()));

    await tester.pumpWidget(toTest);

    expect(find.byType(ListView, skipOffstage: false), findsWidgets);
    expect(find.byType(FabCircularMenu, skipOffstage: false), findsOneWidget);
  });

  testWidgets('Filters appear', (WidgetTester tester) async {
    Widget toTest =
        const MaterialApp(home: const Scaffold(body: const HomePage()));

    await tester.pumpWidget(toTest);

    await tester.tap(find.byIcon(Icons.filter_list));
    // animation expansion
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.fireplace), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.flash_on), findsOneWidget);
  });
}
