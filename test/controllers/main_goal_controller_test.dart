import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/infra/goal_repository.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class GetGoalDetailsCat extends Fake implements GetGoalDetails {
  @override
  Future<MainGoal> get(String id) async {
    return MainGoal("1", "Title", "Desc");
  }
}

void main() {
  late MainGoalController mainGoalController;

  setUp(() async {
    var getGoalDetails = GetGoalDetailsCat();

    mainGoalController = MainGoalController(getGoalDetails);
  });
  group('Main Goal Controller should', () {
    test('get Goal by param id on init', () async {
      //#region Arrange(Given)
      const goalId = "1";
      Get.parameters = {"goalId": goalId};
      //#endregion

      //#region Act(When)
      mainGoalController.onInit();
      //#endregion

      //#region Assert(Then)
      mainGoalController.goalModel;
      expect(mainGoalController.goalModel, isNotNull);
      //#endregion
    });
  });
}
