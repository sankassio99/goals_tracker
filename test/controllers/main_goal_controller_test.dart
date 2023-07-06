import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:mockito/mockito.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  late MainGoalController mainGoalController;
  late GetGoalDetails getGoalDetails;
  late MockIGoalRepository goalRepositoryMock;
  late String goalId;
  late MainGoal myGoal;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    getGoalDetails = GetGoalDetails(goalRepositoryMock);
    var updateGoal = UpdateGoal(goalRepositoryMock);
    goalId = "1";

    mainGoalController = MainGoalController(getGoalDetails, updateGoal);
    Get.parameters = {"goalId": goalId};

    myGoal = MainGoal(goalId, "title", "desc");
    when(goalRepositoryMock.getById(goalId)).thenAnswer((_) async => myGoal);
  });
  group('Main Goal Controller should', () {
    test('get Goal by param id on init', () async {
      //#region Arrange(Given)
      //#endregion

      //#region Act(When)
      mainGoalController.getGoal();
      //#endregion

      //#region Assert(Then)
      mainGoalController.goalModel.listen((model) {
        expect(model.id, goalId);
      });
      //#endregion
    });

    test('update goal title', () async {
      //#region Arrange(Given)
      await mainGoalController.getGoal();
      //#endregion

      //#region Act(When)
      mainGoalController.updateGoal();
      //#endregion

      //#region Assert(Then)
      var matcher = predicate<MainGoal>((goal) {
        expect(goal.id, goalId);
        return true;
      });
      verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
      //#endregion
    });

    test('add task', () async {
      //#region Arrange(Given)
      //#endregion

      //#region Act(When)
      mainGoalController.addTask();

      //#endregion
      //#region Assert(Then)
      expect(mainGoalController.goalModel.value.tasks.length, 1);
      //#endregion
    });

    test('update goal when task is added', () async {
      //#region Arrange(Given)
      await mainGoalController.getGoal();

      //#endregion

      //#region Act(When)
      mainGoalController.addTask();

      //#endregion
      //#region Assert(Then)
      var matcher = predicate<MainGoal>((goal) {
        expect(goal.id, goalId);
        expect(goal.tasks.length, 1);
        return true;
      });
      verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
      //#endregion
    });

    test('update goal progress when task is checked', () async {
      //#region Arrange(Given)
      var myTask1 = Task("myTask1");
      var myTask2 = Task("myTask2");
      myGoal.tasks = [
        myTask1,
        myTask2,
      ];
      myTask1.markAsCompleted();

      await mainGoalController.getGoal();

      //#endregion

      //#region Act(When)

      mainGoalController.onTaskCheck();

      //#endregion
      //#region Assert(Then)
      var progress =
          mainGoalController.goalModel.value.completePercentage.value;
      expect(progress, isNot(0));
      //#endregion
    });

    test('must load with progress percentage already saved', () async {
      //#region Arrange(Given)
      myGoal.completePercentage = 0.5;

      await mainGoalController.getGoal();

      //#endregion

      //#region Act(When)

      //#endregion
      //#region Assert(Then)
      var progress =
          mainGoalController.goalModel.value.completePercentage.value;
      expect(progress, myGoal.completePercentage);
      //#endregion
    });

    test('update goal progress when task is added', () async {
      //#region Arrange(Given)
      var initialProgress = 0.5;
      myGoal.completePercentage = initialProgress;

      await mainGoalController.getGoal();

      //#endregion

      //#region Act(When)

      mainGoalController.addTask();

      //#endregion
      //#region Assert(Then)
      var progress =
          mainGoalController.goalModel.value.completePercentage.value;
      expect(progress, isNot(initialProgress));
      //#endregion
    });

    test('update goal when icon is updated', () async {
      //#region Arrange(Given)
      var goalModel = GoalModel(goalId);
      mainGoalController.goalModel.value = goalModel;

      //#endregion

      //#region Act(When)
      var selectedIcon = PhosphorIcons.fill.notePencil.obs;
      mainGoalController.updateIcon(selectedIcon);

      //#endregion
      //#region Assert(Then)
      var matcher = predicate<MainGoal>((goal) {
        expect(goal.id, goalId);
        expect(goal.icon, selectedIcon.value);
        return true;
      });
      verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
      //#endregion
    });

    test('update goal when final date is selected', () async {
      //#region Arrange(Given)
      var goalModel = GoalModel(goalId);
      mainGoalController.goalModel.value = goalModel;

      //#endregion

      //#region Act(When)
      var selectedDateTime = DateTime(2024, 01, 01);
      goalModel.finalDate = selectedDateTime;
      mainGoalController.updateGoal();

      //#endregion
      //#region Assert(Then)
      var matcher = predicate<MainGoal>((goal) {
        expect(goal.id, goalId);
        expect(goal.finalDate, selectedDateTime);
        return true;
      });
      verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
      //#endregion
    });

    test('update goal when goal type is selected', () async {
      //#region Arrange(Given)
      var goalModel = GoalModel(goalId);
      mainGoalController.goalModel.value = goalModel;

      //#endregion

      //#region Act(When)
      var selectedType = GoalType.monetary;
      goalModel.meansureType = selectedType;
      mainGoalController.updateGoal();

      //#endregion
      //#region Assert(Then)
      var matcher = predicate<MainGoal>((goal) {
        expect(goal.id, goalId);
        expect(goal.type, selectedType);
        return true;
      });
      verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
      //#endregion
    });
  });
}
