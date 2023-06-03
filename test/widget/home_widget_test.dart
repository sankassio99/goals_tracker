import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/infra/goal_repository.dart';
import 'package:goals_tracker/main.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:provider/provider.dart';

void main() {
  late AddNewGoal addNewGoal;
  late GetGoals getGoals;
  late UpdateGoal updateGoal;

  setUp(() {
    var goalRepository = GoalRepositoryMemory();
    addNewGoal = AddNewGoal(goalRepository);
    updateGoal = UpdateGoal(goalRepository);
    getGoals = GetGoals(goalRepository);
  });

  testWidgets('When is loaded must be show a title and button to add new goals',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    // act
    await tester.pumpAndSettle();

    // assert
    var titleFinder = find.byKey(const Key("homeTitle"));
    var buttonFinder = find.byKey(const Key("addNewGoalButton"));

    expect(titleFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('When is add new goal must update goal list view with goal card',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());
    var buttonFinder = find.byKey(const Key("addNewGoalButton"));

    // act
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // assert
    var goalCard = find.byType(GoalCardWidget);
    expect(goalCard, findsOneWidget);
  });

  testWidgets(
      'When add main goal button is clicked must be redirect to new maingoal page created',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeController(
              addNewGoal,
              getGoals,
              updateGoal,
            ),
          ),
        ],
        child: Builder(builder: (_) => const MyApp()),
      ),
    );

    // act
    var buttonFinder = find.byKey(const Key("addNewGoalButton"));

    await tester.tap(buttonFinder);

    await tester.pumpAndSettle();

    // assert
    var mainGoalPageFinder = find.byType(MainGoalPageWidget);
    expect(mainGoalPageFinder, findsOneWidget);
  });

  testWidgets(
      'When new main goal page is created the focus must be in title input',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    // act
    var buttonFinder = find.byKey(const Key("addNewGoalButton"));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // assert
    var titleInputFinder = find.byKey(const Key("titleInput"));
    TextField titleInputWidget = tester.widget(titleInputFinder);
    var hasFocus = titleInputWidget.focusNode!.hasPrimaryFocus;
    expect(hasFocus, isTrue);
  });
}
