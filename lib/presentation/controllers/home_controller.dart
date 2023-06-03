import 'package:get/get.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class HomeController extends GetxController {
  final AddNewGoal _addNewGoal;
  final GetGoals _getGoals;
  RxList<GoalModel> goalList = <GoalModel>[].obs;

  HomeController(this._addNewGoal, this._getGoals);

  void addNewGoal() {
    var goalId = _addNewGoal.execute();
    var newGoal = GoalModel(goalId);
    goalList.add(newGoal);
  }

  Future<void> loadGoals() async {
    goalList.clear();
    var mainGoals = await _getGoals.getAll() as List<MainGoal>;
    for (var mainGoal in mainGoals) {
      goalList.add(_mapToGoalModel(mainGoal));
    }
  }

  GoalModel _mapToGoalModel(MainGoal goal) {
    var goalModel = GoalModel(
      goal.id,
      description: goal.desc,
      name: goal.title,
    );

    return goalModel;
  }
}
