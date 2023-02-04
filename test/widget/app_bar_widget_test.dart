import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/main.dart';

void main() {
  testWidgets('When user tap in button back, must come back to last page',
      (tester) async {
    //#region Arrange(Given)
    await tester.pumpWidget(const MyApp());

    var buttonFinder = find.byKey(const Key("addNewGoalButton"));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    //#endregion

    //#region Act(When)
    var backIconButtonFinder = find.byKey(const Key("backIconButton"));
    await tester.tap(backIconButtonFinder);
    await tester.pumpAndSettle();
    //#endregion

    //#region Assert(Then)
    var homeTitle = find.byKey(const Key("homeTitle"));
    expect(homeTitle, findsOneWidget);
    //#endregion
  });
}
