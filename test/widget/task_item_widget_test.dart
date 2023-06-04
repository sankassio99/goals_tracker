import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

void main() {
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
