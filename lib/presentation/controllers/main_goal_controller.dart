import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_subgoal.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/sub_goal_page_widget.dart';
import '../../domain/entities/main_goal.dart';

class MainGoalController extends ChangeNotifier {
  final UpdateGoal _updateGoal;
  final AddSubgoal _addSubgoal;
  final GetGoalDetails _getGoalDetails;
  late GoalModel currentGoal;
  List<GoalModel> subGoals = [];

  MainGoalController(this._updateGoal, this._addSubgoal, this._getGoalDetails);

  void setCurrentGoal(GoalModel goalModel) {
    currentGoal = goalModel;
  }

  onInputFocusChange(bool focusIn) {
    if (!focusIn) {
      updateGoal();
    }
  }

  void updateGoal() {
    MainGoal goal = _mapMainGoal();

    _updateGoal.execute(goal);
  }

  MainGoal _mapMainGoal() {
    var goal = MainGoal(
      currentGoal.id,
      currentGoal.name,
      currentGoal.description,
    );

    return goal;
  }

  addSubGoal(String goalId) async {
    var subGoalId = await _addSubgoal.execute(goalId);

    subGoals.add(
      GoalModel(subGoalId, description: "", name: "Tap to edit"),
    );

    notifyListeners();
  }

  void goToSubGoal(BuildContext context, GoalModel goalModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubGoalPageWidget(
          isCreatedNow: false.obs,
          goalModel: goalModel,
        ),
      ),
    );
  }

  Future<GoalModel> getGoalDetails(String goalId) async {
    var goal = await _getGoalDetails.get(goalId);
    return _mapToGoalModel(goal);
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
