import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/services/observable.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomeController extends ChangeNotifier {
  final AddNewGoal _addNewGoal;
  final GetGoals _getGoals;
  final UpdateGoal _updateGoal;
  List<GoalModel> goalList = [];

  HomeController(this._addNewGoal, this._getGoals, this._updateGoal) {
    _updateGoal.register(Observer("updateGoal", (data) {
      getAllGoals();
    }));
  }

  getAllGoals() async {
    goalList = [];
    var goals = await _getGoals.getAll();

    for (var goal in goals) {
      goalList.add(
        GoalModel(goal.id, description: goal.desc, name: goal.title),
      );
    }

    notifyListeners();
  }

  void addNewGoal() {
    var goalId = _addNewGoal.execute();
    var newGoal = GoalModel(goalId);
    goalList.add(newGoal);
    notifyListeners();
  }

  void goToMainGoal(BuildContext context, GoalModel goalModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainGoalPageWidget(
          isCreatedNow: true.obs,
          goalModel: goalModel,
        ),
      ),
    );
  }
}
