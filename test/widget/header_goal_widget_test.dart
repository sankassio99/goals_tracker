import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

void main() {
  testWidgets('When Header Goal Widget is loaded must show input title',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderGoalWidget(model: GoalModel("")),
        ),
      ),
    );
    // act

    // assert
    var input = find.byKey(const Key("titleInput"));
    expect(input, findsOneWidget);
  });

  testWidgets('When Header Goal Widget is loaded must show input description',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderGoalWidget(model: GoalModel("")),
        ),
      ),
    );
    // act

    // assert
    var input = find.byKey(const Key("descInput"));
    expect(input, findsOneWidget);
  });

  testWidgets(
      'When Header Goal Widget is loaded must display title and description',
      (WidgetTester tester) async {
    // arrange
    var title = "Buy a new car";
    var description = "Lorem ipsum";
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderGoalWidget(
              model: GoalModel(
            "",
            name: title,
            description: description,
          )),
        ),
      ),
    );

    // act

    // assert
    var inputTitle = find.byKey(const Key("titleInput"));
    var inputDesc = find.byKey(const Key("descInput"));

    TextField inputTitleWidget = tester.widget(inputTitle);
    expect(inputTitleWidget.controller!.text, title);

    TextField inputDescWidget = tester.widget(inputDesc);
    expect(inputDescWidget.controller!.text, description);
  });
}