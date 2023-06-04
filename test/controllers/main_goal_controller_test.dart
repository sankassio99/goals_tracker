import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:mockito/mockito.dart';

import '../add_new_goal_test.mocks.dart';

void main() {
  late MainGoalController mainGoalController;
  late GetGoalDetails getGoalDetails;
  late MockIGoalRepository goalRepositoryMock;
  late String goalId;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    getGoalDetails = GetGoalDetails(goalRepositoryMock);
    var updateGoal = UpdateGoal(goalRepositoryMock);
    goalId = "1";

    mainGoalController = MainGoalController(getGoalDetails, updateGoal);
    Get.parameters = {"goalId": goalId};

    var myGoal = MainGoal(goalId, "title", "desc");
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
  });
}
