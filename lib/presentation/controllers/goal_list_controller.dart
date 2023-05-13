import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

import '../pages/main_goal_page_widget.dart';

class GoalListController extends ChangeNotifier {
  final GetGoalDetails _getGoalDetails;

  GoalListController(this._getGoalDetails);

  goalDetails(BuildContext context, String id) async {
    var goal = await _getGoalDetails.get(id) as MainGoal;
    var goalModel = GoalModel(
      goal.id,
      description: goal.desc,
      name: goal.title,
    );

    var subGoals = _mapToGoalsModel(goal.subGoals);
    goalModel.setSubGoalList(subGoals);

    _goToMainGoal(context, goalModel);
  }

  List<GoalModel> _mapToGoalsModel(List<SubGoal> subGoals) {
    List<GoalModel> subGoalsList = [];

    for (var subGoal in subGoals) {
      subGoalsList.add(GoalModel(subGoal.id, name: subGoal.title));
    }

    return subGoalsList;
  }

  void _goToMainGoal(BuildContext context, GoalModel goalModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainGoalPageWidget(
          isCreatedNow: false.obs,
          goalModel: goalModel,
        ),
      ),
    );
  }
}
