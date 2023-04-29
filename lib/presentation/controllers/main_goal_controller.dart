import 'package:flutter/material.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../../domain/entities/main_goal.dart';

class MainGoalController extends ChangeNotifier {
  final UpdateGoal _updateGoal;
  late GoalModel _currentGoal;

  MainGoalController(this._updateGoal);

  onInputFocusChange(bool focusIn) {
    if (!focusIn) {
      updateGoal();
    }
  }

  void updateGoal() {
    var goal = MainGoal(
      _currentGoal.id,
      _currentGoal.name,
      _currentGoal.description,
    );

    _updateGoal.execute(goal);
  }

  void setCurrentGoal(GoalModel goalModel) {
    _currentGoal = goalModel;
  }
}
