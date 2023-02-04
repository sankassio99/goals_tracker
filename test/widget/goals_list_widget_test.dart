import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/presentation/components/goal_list_widget.dart';

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
