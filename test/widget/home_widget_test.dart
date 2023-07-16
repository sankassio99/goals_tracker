import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/main.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/pages/home_page_widget.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../add_new_goal_test.mocks.dart';

void main() {
  late MockIGoalRepository goalRepositoryMock;

  setUp(() {
    goalRepositoryMock = MockIGoalRepository();
    Get.lazyPut<IGoalRepository>(() => goalRepositoryMock);

    var myGoal = MainGoal("goalId", "title", "desc", "100");
    when(goalRepositoryMock.getById(any)).thenAnswer((_) async => myGoal);

    List<MainGoal> mainGoalList = [];
    when(goalRepositoryMock.getAll()).thenAnswer((_) async => mainGoalList);
  });

  testWidgets('When is loaded must be show a title and button to add new goals',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    // act
    await tester.pumpAndSettle();

    // assert
    var titleFinder = find.byKey(const Key("homeTitle"));
    var buttonFinder = find.byKey(const Key("dialogAddGoal"));

    expect(titleFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('When is add goal button is tapped must open dialog',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());
    var buttonFinder = find.byKey(const Key("dialogAddGoal"));

    // act
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // assert
    var addGoalDialog = find.byKey(const Key("addGoalDialog"));
    expect(addGoalDialog, findsOneWidget);
  });

  testWidgets('When is add new goal must update goal list view with goal card',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    var buttonFinder = find.byKey(const Key("dialogAddGoal"));

    // act
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // assert
    var goalCard = find.byType(GoalCardWidget);
    expect(goalCard, findsOneWidget);
  });

  testWidgets('When a goal card is tapped must be redirect to main goal page',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(const MyApp());

    var buttonFinder = find.byKey(const Key("dialogAddGoal"));
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // act
    var goalCard = find.byType(GoalCardWidget);
    await tester.tap(goalCard);
    await tester.pumpAndSettle();

    // assert
    var mainGoalPageFinder = find.byType(MainGoalPageWidget);
    expect(mainGoalPageFinder, findsOneWidget);
  });

  testWidgets(
      'When user return from main goal page the goals already registred must be displayed',
      (WidgetTester tester) async {
    // arrange
    var goal1 = MainGoal("1", "title", "desc", "100");
    List<MainGoal> mainGoalList = [goal1];
    when(goalRepositoryMock.getAll()).thenAnswer((_) async => mainGoalList);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    var goalCard = find.byType(GoalCardWidget);
    await tester.tap(goalCard);
    await tester.pumpAndSettle();

    // act
    var backButton = find.byKey(const Key("backIconButton"));
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // assert
    var homePageFinder = find.byType(HomePageWidget);

    expect(homePageFinder, findsOneWidget);
    expect(goalCard, findsNWidgets(1));
  });

  testWidgets('When home widget loads must show all goals list saved',
      (WidgetTester tester) async {
    // arrange
    var goal1 = MainGoal("1", "title", "desc", "100");
    var goal2 = MainGoal("2", "title", "desc", "100");
    List<MainGoal> mainGoalList = [goal1, goal2];

    when(goalRepositoryMock.getAll()).thenAnswer((_) async => mainGoalList);

    await tester.pumpWidget(const MyApp());

    // act
    await tester.pumpAndSettle();

    // assert
    var goalCard = find.byType(GoalCardWidget);
    expect(goalCard, findsNWidgets(2));
  });

  testWidgets(
      'When redirected to main goal page must be show the current goal icon',
      (WidgetTester tester) async {
    // arrange
    var goal1 = MainGoal("1", "title", "desc", "100",
        icon: PhosphorIcons.regular.target);
    List<MainGoal> mainGoalList = [goal1];

    when(goalRepositoryMock.getAll()).thenAnswer((_) async => mainGoalList);
    when(goalRepositoryMock.getById(any)).thenAnswer((_) async => goal1);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // act
    var goalCard = find.byType(GoalCardWidget);
    await tester.tap(goalCard);
    await tester.pumpAndSettle();

    // assert
    var currentGoalIcon = find.byKey(const Key("goalIcon"));
    Icon currentIconWidget = tester.widget(currentGoalIcon);

    expect(currentIconWidget.icon, goal1.icon);
  });
}
