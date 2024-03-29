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

  void addGoal(GoalModel model) {
    var goalId = _addNewGoal.create(
      model.name.text,
      model.target.text,
      model.meansureType.type,
    );
    model.id = goalId;
    goalList.add(model);
  }

  Future<void> loadGoals() async {
    List<GoalModel> goalModelList = [];
    var mainGoals = await _getGoals.getAll();

    for (var mainGoal in mainGoals) {
      goalModelList.add(GoalModel.toModel(mainGoal as MainGoal));
    }

    goalList.value = goalModelList;
  }
}
