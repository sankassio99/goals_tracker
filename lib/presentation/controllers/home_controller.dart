import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class HomeController extends GetxController {
  final AddNewGoal _addNewGoal;
  final GetGoals _getGoals;
  final UpdateGoal _updateGoal;
  List<GoalModel> goalList = [];

  HomeController(this._addNewGoal, this._getGoals, this._updateGoal);

  void addNewGoal() {
    var goalId = _addNewGoal.execute();
    var newGoal = GoalModel(goalId);
    goalList.add(newGoal);
  }
}
