import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

void main() {
  testWidgets('When Main Goal Page Widget is loaded must show header',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MainGoalPageWidget(model: GoalModel("")),
        ),
      ),
    );
    // act

    // assert
    var header = find.byType(HeaderGoalWidget);
    expect(header, findsOneWidget);
  });
}
