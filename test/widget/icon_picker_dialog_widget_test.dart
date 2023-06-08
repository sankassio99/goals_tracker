import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/icon_picker_dialog.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../add_new_goal_test.mocks.dart';

void main() {
  setUp(() {
    var goalRepository = MockIGoalRepository();

    var getGoalDetails = GetGoalDetails(goalRepository);
    var updateGoal = UpdateGoal(goalRepository);

    Get.lazyPut(() => MainGoalController(getGoalDetails, updateGoal));
  });
  testWidgets('Icon Picker Dialog Widget should display all 16 icons',
      (tester) async {
    //#region Arrange(Given)
    var model = GoalModel("");
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderGoalWidget(model: model),
        ),
      ),
    );
    //#endregion

    //#region Act(When)
    var iconBtn = find.byKey(const Key("goalIconBtn"));
    await tester.tap(iconBtn);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var icons = find.byKey(const Key("iconItemChoice"));
    expect(icons, findsNWidgets(16));
    //#endregion
  });

  testWidgets('When tap in a icon must be selected', (tester) async {
    //#region Arrange(Given)
    var model = GoalModel("");
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderGoalWidget(model: model),
        ),
      ),
    );
    // open dialog
    var iconBtn = find.byKey(const Key("goalIconBtn"));
    await tester.tap(iconBtn);
    await tester.pumpAndSettle();
    //#endregion

    //#region Act(When)
    var firstIcon = find.byKey(const Key("iconItemChoice")).first;
    await tester.tap(firstIcon);
    //#endregion

    //#region Assert(Then)
    var selectedIcon = find.byType(SelectedIcon);
    expect(selectedIcon, findsOneWidget);
    //#endregion
  });
}
