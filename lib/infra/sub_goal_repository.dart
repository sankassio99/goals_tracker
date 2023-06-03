import 'package:goals_tracker/application/adapters/isub_goal_repository.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

class SubGoalRepositoryMemory implements ISubGoalRepository {
  late List<SubGoal> goalsData;

  SubGoalRepositoryMemory() {
    goalsData = [];
  }

  @override
  void save(SubGoal goal) {
    // ignore: avoid_print
    print("SAVING NEW SUB GOAL");
    goalsData.add(goal);
  }

  @override
  Future<List<SubGoal>> getAll() async {
    // ignore: avoid_print
    print("GETTING ALL");
    return goalsData;
  }

  @override
  void update(SubGoal goal) {
    // ignore: avoid_print
    print("UPDATING GOAL");
    var goalIndex = goalsData.indexWhere((data) => data.id == goal.id);
    goalsData[goalIndex] = goal;
  }

  @override
  Future<SubGoal> getById(String id) async {
    // ignore: avoid_print
    print("GETTING BY ID");
    return goalsData.firstWhere((data) => data.id == id);
  }

  @override
  Future<List<SubGoal>> getByMainGoalId(String id) async {
    // ignore: avoid_print
    print("GETTING BY MAIN GOAL ID");
    var subGoals = goalsData.where((data) => data.mainGoalId == id).toList();
    return subGoals;
  }
}
