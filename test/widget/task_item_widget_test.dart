import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  setUp(() {
    var goalRepositoryMock = MockIGoalRepository();
    var getGoalDetails = GetGoalDetails(goalRepositoryMock);
    var updateGoal = UpdateGoal(goalRepositoryMock);

    Get.lazyPut(() => MainGoalController(
          getGoalDetails,
          updateGoal,
        ));
  });

  testWidgets('Should load task list', (tester) async {
    //#region Arrange(Given)

    RxList<TaskModel> tasks = [TaskModel("title1"), TaskModel("title2")].obs;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TasksWidget(tasks: tasks),
        ),
      ),
    );
    //#endregion

    //#region Act(When)
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var tasksWidget = find.byType(CheckboxListTile);
    expect(tasksWidget, findsNWidgets(2));
    //#endregion
  });
}