import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class HomeController extends GetxController {
  final AddNewGoal _addNewGoal;
  RxList<GoalModel> goalList = <GoalModel>[].obs;

  HomeController(this._addNewGoal);

  void addNewGoal() {
    var goalId = _addNewGoal.execute();
    var newGoal = GoalModel(goalId);
    goalList.add(newGoal);
  }

  void loadGoals() {}
}
