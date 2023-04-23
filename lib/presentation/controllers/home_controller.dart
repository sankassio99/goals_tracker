import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomeController extends ChangeNotifier {
  AddNewGoal _addNewGoal;

  HomeController(this._addNewGoal);

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
