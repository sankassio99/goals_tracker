import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
  const String goalId = "1";

  setUp(() {
    Get.reset();
    goalRepositoryMock = MockIGoalRepository();
    bindingFake = MainGoalBindingFake(goalRepositoryMock);

    var myGoal = MainGoal(goalId, "title", "desc");
    when(goalRepositoryMock.getById(goalId)).thenAnswer((_) async => myGoal);
  });

  GetMaterialApp initMaterialApp({String goalId = goalId}) {
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
      expect(goal.id, goalId);
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
      expect(goal.id, goalId);
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
    var tasks = find.byKey(const Key("taskItem"));
    expect(tasks, findsOneWidget);
  });
}
