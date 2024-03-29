import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/delete_goal.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/day_entry_model.dart';
import 'package:goals_tracker/presentation/models/deposit_entry_model.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainGoalController extends GetxController {
  Rx<GoalModel> goalModel = Rx<GoalModel>(GoalModel("id", "100"));
  late final GetGoalDetails _getGoalDetails;
  late final UpdateGoal _updateGoal;
  late final DeleteGoal _deleteGoal;

  MainGoalController(this._getGoalDetails, this._updateGoal, this._deleteGoal);

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

  void addDepositEntry(String value) {
    // TODO: use double intead string, please
    var monetaryValue = double.parse(value);
    var depositEntry = DepositEntryModel(monetaryValue);
    goalModel.value.addDepositEntry(depositEntry);
    goalModel.value.updateProgress();
    updateGoal();
  }

  int? getLeftDays(DateTime today) {
    var finalDate = goalModel.value.finalDate;
    var difference = finalDate?.difference(today).inDays;
    return difference;
  }

  void addDayEntry(DateTime dateTime) {
    var dayEntry = DayEntryModel(dateTime);
    goalModel.value.dayEntries.add(dayEntry);
    goalModel.value.updateProgress();
    updateGoal();
  }

  void delete(String id) {
    _deleteGoal.execute(id);
  }
}
