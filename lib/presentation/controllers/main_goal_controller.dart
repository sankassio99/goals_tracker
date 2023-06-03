import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class MainGoalController extends GetxController {
  Rx<GoalModel> goalModel = Rx<GoalModel>(GoalModel("id"));
  late final GetGoalDetails _getGoalDetails;
  late final UpdateGoal _updateGoal;

  MainGoalController(this._getGoalDetails, this._updateGoal);

  getGoal() async {
    var goalId = Get.parameters['goalId'];
    var mainGoal = await _getGoalDetails.get(goalId!);
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

  void updateGoal() {
    _updateGoal.execute(goalModel.value.toMainGoalEntity());
  }
}
