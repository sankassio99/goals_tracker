import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  setUp(() {
    var goalRepository = MockIGoalRepository();

    var getGoalDetails = GetGoalDetails(goalRepository);
    var updateGoal = UpdateGoal(goalRepository);

    Get.lazyPut(() => MainGoalController(getGoalDetails, updateGoal));
  });

  testWidgets('When Header Goal Widget is loaded must show input title',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(
      GetMaterialApp(
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

  testWidgets('When tap in icon must open modal icon picker',
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
    var iconBtn = find.byKey(const Key("goalIconBtn"));
    await tester.tap(iconBtn);
    await tester.pumpAndSettle();

    // assert
    var iconPickerDialog = find.byKey(const Key("iconPickerDialog"));
    expect(iconPickerDialog, findsOneWidget);
  });
}
