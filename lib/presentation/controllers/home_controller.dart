import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomeController extends ChangeNotifier {
  AddNewGoal _addNewGoal;

  HomeController(this._addNewGoal);

  void addNewGoal(BuildContext context) {
    _addNewGoal.execute();

    goToMainGoal(context);
  }

  void goToMainGoal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainGoalPageWidget(
          isCreatedNow: true.obs,
        ),
      ),
    );
  }
}
