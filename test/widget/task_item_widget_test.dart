import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:goals_tracker/presentation/components/tasks_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:mockito/mockito.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  late MockIGoalRepository goalRepositoryMock;

  setUp(() {
    goalRepositoryMock = MockIGoalRepository();
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

  testWidgets('When click in trash must delete task', (tester) async {
    //#region Arrange(Given)

    RxList<TaskModel> tasks = [TaskModel("title1"), TaskModel("title2")].obs;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TasksWidget(tasks: tasks),
        ),
      ),
    );

    await tester.pumpAndSettle();

    //#endregion

    //#region Act(When)
    var taskItem = find.byKey(const Key("taskItemIcon"));
    await tester.tap(taskItem.first);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var tasksWidget = find.byType(CheckboxListTile);
    expect(tasksWidget, findsOneWidget);
    //#endregion
  });

  testWidgets(
      'When Main Goal Page Widget is loaded must show tasks already saved',
      (WidgetTester tester) async {
    // arrange
    var myId = "3";
    var myGoal = MainGoal(myId, "title", "desc");
    myGoal.tasks = [Task("title"), Task("title"), Task("title")];

    when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

    // act
    await tester.pumpWidget(initMaterialApp(myGoal.id));
    await tester.pumpAndSettle();

    // assert
    var tasksWidget = find.byType(CheckboxListTile);
    expect(tasksWidget, findsNWidgets(3));
  });

}

GetMaterialApp initMaterialApp(String goalId) {
  return GetMaterialApp(
    initialRoute: '/mainGoalDetails/$goalId',
    getPages: [
      GetPage(
        name: '/mainGoalDetails/:goalId',
        page: () => MainGoalPageWidget(),
      ),
    ],
  );
}
