import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/components/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../add_new_goal_test.mocks.dart';

class MainGoalBindingFake extends Bindings {
  late IGoalRepository goalRepository;

  MainGoalBindingFake(this.goalRepository);

  @override
  void dependencies() {
    var getGoalDetails = GetGoalDetails(goalRepository);
    var updateGoal = UpdateGoal(goalRepository);

    Get.lazyPut(() => MainGoalController(getGoalDetails, updateGoal));
  }
}

@GenerateMocks([IGoalRepository])
void main() {
  late MockIGoalRepository goalRepositoryMock;
  late Bindings bindingFake;
  late MainGoal mainGoal;

  setUp(() {
    Get.reset();
    goalRepositoryMock = MockIGoalRepository();
    bindingFake = MainGoalBindingFake(goalRepositoryMock);

    mainGoal = MainGoal(
        "111100000", "Goals Tracker App", "Finish until the end of the year");
    when(goalRepositoryMock.getById(mainGoal.id))
        .thenAnswer((_) async => mainGoal);
  });

  GetMaterialApp initMaterialApp({String goalId = "111100000"}) {
    return GetMaterialApp(
      initialRoute: '/mainGoalDetails/$goalId',
      getPages: [
        GetPage(
          name: '/mainGoalDetails/:goalId',
          page: () => MainGoalPageWidget(),
          binding: bindingFake,
        ),
      ],
    );
  }

  testWidgets('When Main Goal Page Widget is loaded must show header',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    // act

    // assert
    var header = find.byType(HeaderGoalWidget);
    expect(header, findsOneWidget);
  });

  testWidgets('When Main Goal Page Widget is loaded must show goal title',
      (WidgetTester tester) async {
    var goalId2 = "2";
    var title = "Buy new car";
    var desc = "Lorem ipsum";
    var myGoal = MainGoal(goalId2, title, desc);

    when(goalRepositoryMock.getById(goalId2)).thenAnswer((_) async => myGoal);

    // arrange
    await tester.pumpWidget(initMaterialApp(goalId: goalId2));
    // act
    await tester.pumpAndSettle();
    var inputTitle = find.byKey(const Key("titleInput"));

    // assert
    TextField inputTitleWidget = tester.widget(inputTitle);
    expect(inputTitleWidget.controller!.text, title);
  });

  testWidgets('When focus out title must update goal',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    var newTitle = "Teste";

    // act
    var inputTitle = find.byKey(const Key("titleInput"));
    await tester.tap(inputTitle);
    await tester.enterText(inputTitle, newTitle);

    var inputDesc = find.byKey(const Key("descInput"));
    await tester.tap(inputDesc);

    await tester.pumpAndSettle();

    // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, mainGoal.id);
      expect(goal.title, newTitle);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });

  testWidgets('When focus out description input must update goal',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    var newDesc = "Desc";

    // act
    var inputDesc = find.byKey(const Key("descInput"));
    await tester.tap(inputDesc);
    await tester.enterText(inputDesc, newDesc);

    var inputTitle = find.byKey(const Key("titleInput"));
    await tester.tap(inputTitle);

    await tester.pumpAndSettle();

    // assert
    var matcher = predicate<MainGoal>((goal) {
      expect(goal.id, mainGoal.id);
      expect(goal.desc, newDesc);
      return true;
    });
    verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
  });
  testWidgets('When confirm Icon Picker Dialog must update current goal icon',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());
    await tester.pumpAndSettle();

    // act
    var iconBtn = find.byKey(const Key("goalIcon"));
    await tester.ensureVisible(iconBtn);
    await tester.tap(iconBtn);
    await tester.pumpAndSettle();

    var selectedIcon = find.byKey(const Key("iconItemChoice")).first;
    Icon selectedIconWidget = tester.widget(selectedIcon);
    await tester.tap(selectedIcon);
    await tester.pumpAndSettle();

    var confirmBtn = find.byKey(const Key("confirmIconChoice"));
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();

    // assert
    var currentGoalIcon = find.byKey(const Key("goalIcon"));
    Icon currentIconWidget = tester.widget(currentGoalIcon);

    expect(currentIconWidget.icon, selectedIconWidget.icon);
  });

  testWidgets(
      'When tap in settings icon in app bar must open dialog settings goal',
      (WidgetTester tester) async {
    // arrange
    await tester.pumpWidget(initMaterialApp());

    // act
    var settingIcon = find.byKey(const Key("goalSettings"));
    await tester.tap(settingIcon);
    await tester.pumpAndSettle();

    // assert
    var settingsDialog = find.byKey(const Key("settingsDialog"));
    expect(settingsDialog, findsOneWidget);
  });

  testWidgets('When open dialog settings goal must load goal data',
      (WidgetTester tester) async {
    // arrange

    when(goalRepositoryMock.getById(mainGoal.id))
        .thenAnswer((_) async => mainGoal);

    await tester.pumpWidget(initMaterialApp());

    // act
    var settingIcon = find.byKey(const Key("goalSettings"));
    await tester.tap(settingIcon);
    await tester.pumpAndSettle();

    // assert
    FormFieldWidget title = tester.widget(find.byKey(const Key("goalName")));
    FormFieldWidget description =
        tester.widget(find.byKey(const Key("goalDescription")));

    expect(title.controller.text, mainGoal.title);
    expect(description.controller.text, mainGoal.desc);
    // expect(desc, findsOneWidget);
  });
}
