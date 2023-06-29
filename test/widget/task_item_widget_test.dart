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
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  late MockIGoalRepository goalRepositoryMock;

  setUp(() {
    Get.reset();
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

  testWidgets('When click in float action button must be added new task',
      (WidgetTester tester) async {
    // arrange
    var myId = "3";
    var myGoal = MainGoal(myId, "title", "desc");
    myGoal.tasks = [];

    when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);
    await tester.pumpWidget(initMaterialApp(myId));

    // act
    var addTaskButton = find.byKey(const Key("addTaskButton"));
    await tester.tap(addTaskButton);

    await tester.pumpAndSettle();

    // assert
    var tasks = find.byType(CheckboxListTile);
    expect(tasks, findsOneWidget);
  });

  testWidgets('When focus out task name must update goal',
      (WidgetTester tester) async {
    // arrange
    var myId = "3";
    var myGoal = MainGoal(myId, "title", "desc");
    myGoal.tasks = [Task("title"), Task("title"), Task("title")];
    when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

    await tester.pumpWidget(initMaterialApp(myId));
    await tester.pumpAndSettle();

    const newName = "Name edited";

    // act
    var inputTask = find.byKey(const Key("inputTask"));
    await tester.enterText(inputTask.first, newName);

    await tester.tapAt(const Offset(100, 100));

    await tester.pumpAndSettle();

    // // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, myGoal.id);
      expect(goal.tasks.first.title, newName);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });

  // testWidgets('When check task must update progress bar percent',
  //     (WidgetTester tester) async {
  //   // arrange
  //   var myId = "3";
  //   var myGoal = MainGoal(myId, "title", "desc");
  //   myGoal.tasks = [Task("title"), Task("title")];
  //   when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

  //   await tester.pumpWidget(initMaterialApp(myId));
  //   await tester.pumpAndSettle();

  //   // act
  //   var taskItem = find.byType(CheckboxListTile);
  //   await tester.tap(taskItem.first);

  //   await tester.pumpAndSettle();

  //   // assert
  //   var progressBarFinder = find.byKey(const Key("progressBar"));
  //   LinearPercentIndicator progressBar = tester.widget(progressBarFinder);
  //   expect(progressBar.percent, 0.5);
  // });

  testWidgets('When add new task must update progress bar percent',
      (WidgetTester tester) async {
    // arrange
    var myTask1 = Task("myTask1");
    var myTask2 = Task("myTask2");
    myTask2.markAsCompleted();
    var myId = "3";
    var myGoal = MainGoal(myId, "title", "desc");
    myGoal.tasks = [myTask1, myTask2];
    when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

    await tester.pumpWidget(initMaterialApp(myId));
    await tester.pumpAndSettle();

    // act
    var addTaskButton = find.byKey(const Key("addTaskButton"));
    await tester.tap(addTaskButton);

    await tester.pumpAndSettle();

    // assert
    var progressBarFinder = find.byKey(const Key("progressBar"));
    LinearPercentIndicator progressBar = tester.widget(progressBarFinder);
    expect(progressBar.percent, 0.33);
  });

  // testWidgets('When check task must update goal', (WidgetTester tester) async {
  //   // arrange
  //   var myTask = Task("myTask");

  //   var myId = "3";
  //   var myGoal = MainGoal(myId, "title", "desc");
  //   myGoal.tasks = [myTask, Task("title1"), Task("title2")];
  //   when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

  //   await tester.pumpWidget(initMaterialApp(myId));
  //   await tester.pumpAndSettle();

  //   // act
  //   var taskItem = find.byKey(const Key("trashTaskIcon"));

  //   await tester.tap(taskItem.first);

  //   await tester.pumpAndSettle();

  //   // // assert
  //   var matcher = predicate<MainGoal>((goal) {
  //     expect(goal.id, myGoal.id);
  //     expect(goal.tasks.first.title, myTask.title);
  //     expect(goal.tasks.first.isCompleted, true);
  //     return true;
  //   });
  //   verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  // });

  testWidgets('When tap in trash must delete task', (tester) async {
    //#region Arrange(Given)

    var myId = "3";
    var myGoal = MainGoal(myId, "title", "desc");
    myGoal.tasks = [Task("title"), Task("title")];
    when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

    await tester.pumpWidget(initMaterialApp(myId));
    await tester.pumpAndSettle();

    var editModeTasksButton = find.byKey(const Key("editModeTasksButton"));
    await tester.tap(editModeTasksButton);
    await tester.pumpAndSettle();

    //#endregion

    //#region Act(When)
    var taskItem = find.byKey(const Key("trashTaskIcon"));
    await tester.tap(taskItem.first);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var tasksWidget = find.byType(CheckboxListTile);
    expect(tasksWidget, findsOneWidget);
    //#endregion
  });

  testWidgets('When tap edit button must show trash icon', (tester) async {
    //#region Arrange(Given)

    var myId = "3";
    var myGoal = MainGoal(myId, "title", "desc");
    myGoal.tasks = [Task("title")];
    when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);

    await tester.pumpWidget(initMaterialApp(myId));
    await tester.pumpAndSettle();

    //#endregion
    var trashTaskIcon = find.byKey(const Key("trashTaskIcon"));
    expect(trashTaskIcon, findsNothing);

    //#region Act(When)
    var editModeTasksButton = find.byKey(const Key("editModeTasksButton"));
    await tester.tap(editModeTasksButton);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    trashTaskIcon = find.byKey(const Key("trashTaskIcon"));
    expect(trashTaskIcon, findsOneWidget);
    //#endregion
  });

  // testWidgets('When add new task must active edit mode',
  //     (WidgetTester tester) async {
  //   // arrange
  //   var myId = "3";
  //   var myGoal = MainGoal(myId, "title", "desc");
  //   myGoal.tasks = [];

  //   when(goalRepositoryMock.getById(myId)).thenAnswer((_) async => myGoal);
  //   await tester.pumpWidget(initMaterialApp(myId));

  //   // act
  //   var addTaskButton = find.byKey(const Key("addTaskButton"));
  //   await tester.tap(addTaskButton);
  //   await tester.pumpAndSettle();

  //   // assert
  //   var editModeTextButton = find.text("Ok");
  //   expect(editModeTextButton, findsOneWidget);
  // });
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
