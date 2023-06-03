import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class MainGoalController extends GetxController {
  Rx<GoalModel> goalModel = Rx<GoalModel>(GoalModel("id"));
  late final GetGoalDetails _getGoalDetails;

  MainGoalController(this._getGoalDetails);

  @override
  void onInit() {
    var goalId = Get.parameters['goalId'];
    if (goalId != null) {
      getGoal(goalId);
    }
    super.onInit();
  }

  getGoal(String goalId) async {
    var mainGoal = await _getGoalDetails.get(goalId);
    goalModel.value = _mapToGoalModel(mainGoal);
    update();
  }

  GoalModel _mapToGoalModel(MainGoal goal) {
    var goalModel = GoalModel(
      goal.id,
      description: goal.desc,
      name: goal.title,
    );

    return goalModel;
  }
}
