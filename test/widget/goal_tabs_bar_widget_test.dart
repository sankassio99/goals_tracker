import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:mockito/mockito.dart';
import '../add_new_goal_test.mocks.dart';

void main() {
  late MockIGoalRepository goalRepositoryMock;

  setUp(() {
    Get.reset();
    goalRepositoryMock = MockIGoalRepository();
  });

  testWidgets('When goal is tasks type must show My tasks tab', (tester) async {
    //#region Arrange(Given)
    var myGoal = MainGoal("myId", "title", "desc", "100");

    myGoal.type = GoalType.tasks;

    await tester.pumpWidget(initMainGoalPage(myGoal, goalRepositoryMock));
    await tester.pumpAndSettle();
    //#endregion

    //#region Act(When)
    //#endregion

    //#region Assert(Then)
    var tasksIconTab = find.byKey(const Key("tasksIconTab"));
    expect(tasksIconTab, findsOneWidget);

    var myTasksTab = find.byKey(const Key("myTasksTab"));
    expect(myTasksTab, findsOneWidget);
    //#endregion
  });

  // TODO: When goal is monetary type must show deposit entry tab
}

// TODO: pass to utils test files
/// Don't forget to use pumpAndSettle() after call this function
GetMaterialApp initMainGoalPage(
    MainGoal myGoal, MockIGoalRepository goalRepositoryMock) {
  var getGoalDetails = GetGoalDetails(goalRepositoryMock);
  var updateGoal = UpdateGoal(goalRepositoryMock);

  Get.lazyPut(() => MainGoalController(
        getGoalDetails,
        updateGoal,
      ));

  when(goalRepositoryMock.getById(myGoal.id)).thenAnswer((_) async => myGoal);

  return GetMaterialApp(
    initialRoute: '/mainGoalDetails/${myGoal.id}',
    getPages: [
      GetPage(
        name: '/mainGoalDetails/:goalId',
        page: () => MainGoalPageWidget(),
      ),
    ],
  );
}
