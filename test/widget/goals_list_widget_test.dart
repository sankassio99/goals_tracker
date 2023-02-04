import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('When is loaded must be show a list of goal cards',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GoalListWidget(),
        ),
      ),
    );
    // act

    // assert
    var listViewFinder = find.byKey(const Key("goalCardsListView"));
    expect(listViewFinder, findsOneWidget);
  });
}

class GoalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
