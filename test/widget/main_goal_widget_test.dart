import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../add_new_goal_test.mocks.dart';

class MainGoalBindingFake extends Bindings {
  late IGoalRepository goalRepository;

  MainGoalBindingFake(this.goalRepository);

  @override
  void dependencies() {
    var getGoalDetails = GetGoalDetails(goalRepository);
    var updateGoal = UpdateGoal(goalRepository);

    Get.lazyPut(() => MainGoalController(getGoalDetails, updateGoal));
  }
}

@GenerateMocks([IGoalRepository])
void main() {
  late MockIGoalRepository goalRepositoryMock;
  late Bindings bindingFake;
  late MainGoal mainGoal;

  setUp(() {
    Get.reset();
    goalRepositoryMock = MockIGoalRepository();
    bindingFake = MainGoalBindingFake(goalRepositoryMock);

    mainGoal = MainGoal("111100000", "title", "desc");
    when(goalRepositoryMock.getById(mainGoal.id))
        .thenAnswer((_) async => mainGoal);
  });

  GetMaterialApp initMaterialApp({String goalId = "111100000"}) {
    return GetMaterialApp(
      initialRoute: '/mainGoalDetails/$goalId',
      getPages: [
        GetPage(
          name: '/mainGoalDetails/:goalId',
          page: () => MainGoalPageWidget(),
          binding: bindingFake,
        ),
      ],
    );
  }

  testWidgets('When Main Goal Page Widget is loaded must show header',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    // act

    // assert
    var header = find.byType(HeaderGoalWidget);
    expect(header, findsOneWidget);
  });

  testWidgets('When Main Goal Page Widget is loaded must show goal title',
      (WidgetTester tester) async {
    var goalId2 = "2";
    var title = "Buy new car";
    var desc = "Lorem ipsum";
    var myGoal = MainGoal(goalId2, title, desc);

    when(goalRepositoryMock.getById(goalId2)).thenAnswer((_) async => myGoal);

    // arrange
    await tester.pumpWidget(initMaterialApp(goalId: goalId2));
    // act
    await tester.pumpAndSettle();
    var inputTitle = find.byKey(const Key("titleInput"));

    // assert
    TextField inputTitleWidget = tester.widget(inputTitle);
    expect(inputTitleWidget.controller!.text, title);
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
    await tester.pumpWidget(initMaterialApp(goalId: myId));
    await tester.pumpAndSettle();

    // assert
    var tasksWidget = find.byType(CheckboxListTile);
    expect(tasksWidget, findsNWidgets(3));
  });

  testWidgets('When focus out title must update goal',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    var newTitle = "Teste";

    // act
    var inputTitle = find.byKey(const Key("titleInput"));
    await tester.tap(inputTitle);
    await tester.enterText(inputTitle, newTitle);

    var inputDesc = find.byKey(const Key("descInput"));
    await tester.tap(inputDesc);

    await tester.pumpAndSettle();

    // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, mainGoal.id);
      expect(goal.title, newTitle);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });

  testWidgets('When focus out description input must update goal',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    var newDesc = "Desc";

    // act
    var inputDesc = find.byKey(const Key("descInput"));
    await tester.tap(inputDesc);
    await tester.enterText(inputDesc, newDesc);

    var inputTitle = find.byKey(const Key("titleInput"));
    await tester.tap(inputTitle);

    await tester.pumpAndSettle();

    // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, mainGoal.id);
      expect(goal.desc, newDesc);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });
  testWidgets('When click in float action button must be added new task',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());

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
    mainGoal.tasks = [Task("title"), Task("title"), Task("title")];

    await tester.pumpWidget(initMaterialApp());
    await tester.pumpAndSettle();

    const newName = "Name edited";

    // act
    var inputTask = find.byKey(const Key("inputTask"));
    await tester.enterText(inputTask.first, newName);

    await tester.tapAt(const Offset(100, 100));

    await tester.pumpAndSettle();

    // // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, mainGoal.id);
      expect(goal.tasks.first.title, newName);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });

  testWidgets('When check task must update goal', (WidgetTester tester) async {
    // arrange
    var myTask = Task("myTask");
    mainGoal.tasks = [myTask, Task("title2"), Task("title3")];

    await tester.pumpWidget(initMaterialApp());
    await tester.pumpAndSettle();

    // act
    var taskItem = find.byKey(const Key("taskItemIcon"));

    await tester.tap(taskItem.first);

    await tester.pumpAndSettle();

    // // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, mainGoal.id);
      expect(goal.tasks.first.title, myTask.title);
      expect(goal.tasks.first.isCompleted, !myTask.isCompleted);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });

  testWidgets('When check task must update progress bar percent',
      (WidgetTester tester) async {
    // arrange
    var myTask1 = Task("myTask1");
    var myTask2 = Task("myTask2");
    mainGoal.tasks = [
      myTask1,
      myTask2,
    ];

    await tester.pumpWidget(initMaterialApp());
    await tester.pumpAndSettle();

    // act
    var taskItem = find.byKey(const Key("taskItemIcon"));
    await tester.tap(taskItem.first);

    await tester.pumpAndSettle();

    // assert
    var progressBarFinder = find.byKey(const Key("progressBar"));
    LinearPercentIndicator progressBar = tester.widget(progressBarFinder);
    expect(progressBar.percent, 0.5);
  });

  testWidgets('When add new task must update progress bar percent',
      (WidgetTester tester) async {
    // arrange
    var myTask1 = Task("myTask1");
    var myTask2 = Task("myTask2");
    myTask2.markAsCompleted();
    mainGoal.tasks = [myTask1, myTask2];

    await tester.pumpWidget(initMaterialApp());
    await tester.pumpAndSettle();

    // act
    var addTaskButton = find.byKey(const Key("addTaskButton"));
    await tester.tap(addTaskButton);

    await tester.pumpAndSettle();

    // assert
    var progressBarFinder = find.byKey(const Key("progressBar"));
    LinearPercentIndicator progressBar = tester.widget(progressBarFinder);
    expect(progressBar.percent, 0.3);
  });
}
