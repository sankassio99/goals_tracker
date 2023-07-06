import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainGoalController extends GetxController {
  Rx<GoalModel> goalModel = Rx<GoalModel>(GoalModel("id", "100"));
  late final GetGoalDetails _getGoalDetails;
  late final UpdateGoal _updateGoal;

  MainGoalController(this._getGoalDetails, this._updateGoal);

  getGoal() async {
    var goalId = Get.parameters['goalId'];
    var mainGoal = await _getGoalDetails.get(goalId!);
    goalModel.value = GoalModel.toModel(mainGoal);
    update();
  }

  void updateGoal() {
    var mainGoal = goalModel.value.toMainGoalEntity();
    _updateGoal.execute(mainGoal);
  }

  void addTask() {
    goalModel.value.addTask();
    goalModel.value.updateProgress();

    updateGoal();
  }

  void onTaskCheck() {
    goalModel.value.updateProgress();

    updateGoal();
  }

  void updateIcon(Rx<PhosphorIconData> selectedIcon) {
    goalModel.value.changeIcon(selectedIcon);
    updateGoal();
  }

  onDeleteTask(int index) {
    goalModel.value.tasks.removeAt(index);
    goalModel.value.updateProgress();
    updateGoal();
  }

  void reorderTasks(int oldIndex, int newIndex) {
    var task = goalModel.value.tasks.removeAt(oldIndex);
    if (newIndex > 0) {
      newIndex -= 1;
    }
    goalModel.value.tasks.insert(newIndex, task);
  }
}
