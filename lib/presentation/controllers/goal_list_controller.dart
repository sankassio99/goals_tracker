import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

import '../pages/main_goal_page_widget.dart';

class GoalListController extends ChangeNotifier {
  final GetGoalDetails _getGoalDetails;

  GoalListController(this._getGoalDetails);

  goalDetails(BuildContext context, String id) async {
    var goal = await _getGoalDetails.get(id);
    var goalModel = GoalModel(
      goal.id,
      description: goal.desc,
      name: goal.title,
    );
    _goToMainGoal(context, goalModel);
  }

  void _goToMainGoal(BuildContext context, GoalModel newGoal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainGoalPageWidget(
          isCreatedNow: false.obs,
          goalModel: newGoal,
        ),
      ),
    );
  }
}
