import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/main.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

void main() {
  testWidgets('When is loaded must be show a title and button to add new goals',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    // act
    await tester.pumpAndSettle();

    // assert
    var titleFinder = find.byKey(const Key("homeTitle"));
    var buttonFinder = find.byKey(const Key("addNewGoalButton"));

    expect(titleFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets(
      'When add main goal button is clicked must be redirect to new maingoal page created',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    // act
    var buttonFinder = find.byKey(const Key("addNewGoalButton"));

    await tester.tap(buttonFinder);

    await tester.pumpAndSettle();

    // assert
    var mainGoalPageFinder = find.byType(MainGoalPageWidget);
    expect(mainGoalPageFinder, findsOneWidget);
  });

  testWidgets(
      'When new main goal page is created the focus must be in title input',
      (WidgetTester tester) async {
    // arrange
    // await tester.pumpWidget(const HomePageWidget());

    // act

    // assert
  });

  testWidgets('When is loaded must be show a list of main goal cards',
      (WidgetTester tester) async {
    // arrange
    // await tester.pumpWidget(const HomePageWidget());

    // act

    // assert
  });
}
