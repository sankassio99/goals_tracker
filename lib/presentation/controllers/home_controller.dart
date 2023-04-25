import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomeController extends ChangeNotifier {
  AddNewGoal _addNewGoal;
  GetGoals _getGoals;
  List<GoalModel> goalList = List.empty();

  HomeController(this._addNewGoal, this._getGoals) {
    var goals = _getGoals.execute();
    for (var goal in goals) {
      goalList.add(
        GoalModel(goal.id, description: goal.desc, title: goal.title),
      );
    }
  }

  void addNewGoal(BuildContext context) {
    var goalId = _addNewGoal.execute();
    var newGoal = GoalModel(goalId);
    goToMainGoal(context, newGoal);
  }

  void goToMainGoal(BuildContext context, GoalModel newGoal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainGoalPageWidget(
          isCreatedNow: true.obs,
          goalModel: newGoal,
        ),
      ),
    );
  }
}
