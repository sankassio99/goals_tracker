import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
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

    mainGoalController = MainGoalController(getGoalDetails);

    goalId = "1";
    var myGoal = MainGoal(goalId, "title", "desc");
    when(goalRepositoryMock.getById(goalId)).thenAnswer((_) async => myGoal);
  });
  group('Main Goal Controller should', () {
    test('get Goal by param id on init', () async {
      //#region Arrange(Given)
      const goalId = "1";
      Get.parameters = {"goalId": goalId};
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
  });
}
