import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/main.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
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

  testWidgets('When Main Goal Page Widget is loaded must show goal title',
      (WidgetTester tester) async {
    var goalId = "1";
    var title = "Buy new car";

    // arrange
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/mainGoalDetails/:$goalId',
      getPages: [
        GetPage(
          name: '/mainGoalDetails/:goalId',
          page: () => MainGoalPageWidget(
            model: GoalModel("id"),
          ),
          binding: MainGoalBinding(),
        ),
      ],
    ));
    // act
    var inputTitle = find.byKey(const Key("titleInput"));

    // assert
    TextField inputTitleWidget = tester.widget(inputTitle);
    expect(inputTitleWidget.controller!.text, title);
  });
}

class MainGoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainGoalController());
  }
}
