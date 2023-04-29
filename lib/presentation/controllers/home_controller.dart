import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomeController extends ChangeNotifier {
  final AddNewGoal _addNewGoal;
  final GetGoals _getGoals;
  List<GoalModel> goalList = [];

  HomeController(this._addNewGoal, this._getGoals);

  getAllGoals() async {
    goalList = [];
    var goals = await _getGoals.getAll();

    for (var goal in goals) {
      goalList.add(
        GoalModel(goal.id, description: goal.desc, title: goal.title),
      );
    }

    notifyListeners();
  }

  void addNewGoal(BuildContext context) {
    var goalId = _addNewGoal.execute();
    var newGoal = GoalModel(goalId);
    goToMainGoal(context, newGoal);

    getAllGoals();
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
