import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Goal card should show icon, title and percentage of goal',
      (tester) async {
    //#region Arrange(Given)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GoalCardWidget(),
        ),
      ),
    );

    //#endregion

    //#region Act(When)
    //#endregion

    //#region Assert(Then)
    var icon = find.byKey(const Key("goalCardIcon"));
    var title = find.byKey(const Key("goalCardTitle"));
    var percentage = find.byKey(const Key("goalCardPercentage"));
    //#endregion
  });
}

class GoalCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
