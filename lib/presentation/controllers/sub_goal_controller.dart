import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class SubGoalController extends ChangeNotifier {
  late GoalModel currentGoal;

  SubGoalController();

  void setCurrentGoal(GoalModel goalModel) {
    currentGoal = goalModel;
  }

  onInputFocusChange(bool focusIn) {
    if (!focusIn) {}
  }
}
