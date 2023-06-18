import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() {
  testWidgets('Goal card should show icon, title and percentage of goal',
      (tester) async {
    //#region Arrange(Given)
    var model = GoalModel("");
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GoalCardWidget(model: model),
        ),
      ),
    );

    //#endregion

    //#region Act(When)
    //#endregion

    //#region Assert(Then)
    var icon = find.byKey(const Key("goalCardIcon"));
    var title = find.byKey(const Key("goalCardTitle"));
    var percentage = find.byKey(const Key("progressBar"));

    expect(icon, findsOneWidget);
    expect(title, findsOneWidget);
    expect(percentage, findsOneWidget);
    //#endregion
  });

  testWidgets('Goal card should display current percentage value of goal',
      (tester) async {
    //#region Arrange(Given)
    var model = GoalModel("");
    const percentageValue = 0.2;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GoalCardWidget(model: model),
        ),
      ),
    );

    //#endregion

    //#region Act(When)
    model.completePercentage.value = percentageValue;
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var progressBarFinder = find.byKey(const Key("progressBar"));
    LinearPercentIndicator progressBar = tester.widget(progressBarFinder);
    expect(progressBar.percent, percentageValue);
    //#endregion
  });
}
