import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
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
    Get.lazyPut(() => MainGoalController(getGoalDetails));
  }
}

@GenerateMocks([IGoalRepository])
void main() {
  late MockIGoalRepository goalRepositoryMock;
  late Bindings bindingFake;
  const String goalId = "1";

  setUp(() {
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
    var goalId = "1";
    var title = "Buy new car";
    var desc = "Lorem ipsum";
    var myGoal = MainGoal(goalId, title, desc);

    when(goalRepositoryMock.getById(goalId)).thenAnswer((_) async => myGoal);

    // arrange
    await tester.pumpWidget(initMaterialApp(goalId: goalId));
    // act
    await tester.pumpAndSettle();
    var inputTitle = find.byKey(const Key("titleInput"));

    // assert
    TextField inputTitleWidget = tester.widget(inputTitle);
    expect(inputTitleWidget.controller!.text, title);
  });
}
