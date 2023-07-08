import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/components/goalTabs/deposit_entries_widget.dart';
import 'package:goals_tracker/presentation/components/goal_tabs_widget.dart';
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

    var calendarIconTab = find.byKey(const Key("calendarIconTab"));
    expect(calendarIconTab, findsNothing);

    var myDepositsTab = find.byKey(const Key("myDepositsTab"));
    expect(myDepositsTab, findsNothing);
    //#endregion
  });

  testWidgets('When goal is monetary type must show deposit entry tab only',
      (tester) async {
    //#region Arrange(Given)
    var myGoal = MainGoal("myId", "title", "desc", "100");

    myGoal.type = GoalType.monetary;

    await tester.pumpWidget(initMainGoalPage(myGoal, goalRepositoryMock));
    await tester.pumpAndSettle();
    //#endregion

    //#region Act(When)
    var depositsIconTab = find.byKey(const Key("depositsIconTab"));
    await tester.tap(depositsIconTab);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)

    var myDepositsTab = find.byKey(const Key("myDepositsTab"));
    expect(myDepositsTab, findsOneWidget);

    var tasksIconTab = find.byKey(const Key("tasksIconTab"));
    expect(tasksIconTab, findsNothing);

    //#endregion
  });

  testWidgets('When goal is days type must show days entry tab and calendar',
      (tester) async {
    //#region Arrange(Given)
    var myGoal = MainGoal("myId", "title", "desc", "100");

    myGoal.type = GoalType.days;

    await tester.pumpWidget(initMainGoalPage(myGoal, goalRepositoryMock));
    await tester.pumpAndSettle();
    //#endregion

    //#region Act(When)
    var daysIconTab = find.byKey(const Key("daysIconTab"));
    await tester.tap(daysIconTab);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)

    var myDaysTab = find.byKey(const Key("myDaysTab"));
    expect(myDaysTab, findsOneWidget);

    var calendarIconTab = find.byKey(const Key("calendarIconTab"));
    expect(calendarIconTab, findsOneWidget);

    var tasksIconTab = find.byKey(const Key("tasksIconTab"));
    expect(tasksIconTab, findsNothing);

    //#endregion
  });

  testWidgets(
      'When tap in add deposit entry button must show dialog to add deposit',
      (tester) async {
    //#region Arrange(Given)
    var myGoal = MainGoal("myId", "title", "desc", "100");

    myGoal.type = GoalType.monetary;

    await tester.pumpWidget(initMainGoalPage(myGoal, goalRepositoryMock));
    await tester.pumpAndSettle();
    //#endregion

    //#region Act(When)
    var addDepositButton = find.byKey(const Key("addDepositButton"));
    await tester.tap(addDepositButton);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var addDepositEntryDialog = find.byKey(const Key("addDepositEntryDialog"));
    expect(addDepositEntryDialog, findsOneWidget);
    //#endregion
  });

  testWidgets('When tap in add inside dialog entry must add new deposit entry',
      (tester) async {
    //#region Arrange(Given)
    var myGoal = MainGoal("myId", "title", "desc", "100");

    myGoal.type = GoalType.monetary;

    await tester.pumpWidget(initMainGoalPage(myGoal, goalRepositoryMock));
    await tester.pumpAndSettle();

    var depositvalue = 10.0;
    //#endregion

    //#region Act(When)
    var addDepositButton = find.byKey(const Key("addDepositButton"));
    await tester.tap(addDepositButton);
    await tester.pumpAndSettle();

    var depositValueInput = find.byKey(const Key("depositValueInput"));
    await tester.enterText(depositValueInput, depositvalue.toString());
    await tester.pumpAndSettle();

    var confirmAddDeposit = find.byKey(const Key("confirmAddDeposit"));
    await tester.tap(confirmAddDeposit);
    await tester.pumpAndSettle();

    //#endregion

    //#region Assert(Then)
    var depositValueAdded = find.byType(DepositEntryWidget);
    expect(depositValueAdded, findsOneWidget);
    //#endregion
  });
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
