import 'package:flutter/material.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/add_subgoal.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../../domain/entities/main_goal.dart';

class MainGoalController extends ChangeNotifier {
  final UpdateGoal _updateGoal;
  final AddSubgoal _addSubgoal;
  late GoalModel _currentGoal;
  List<GoalModel> subGoalList = [];

  MainGoalController(this._updateGoal, this._addSubgoal);

  void setCurrentGoal(GoalModel goalModel) {
    _currentGoal = goalModel;
    subGoalList = goalModel.subGoals;
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
      _currentGoal.id,
      _currentGoal.name,
      _currentGoal.description,
    );

    return goal;
  }

  addSubGoal() async {
    var subGoalId = await _addSubgoal.execute(_currentGoal.id);

    subGoalList.add(
      GoalModel(subGoalId, description: "", name: "New Sub Goal"),
    );

    notifyListeners();
  }
}
