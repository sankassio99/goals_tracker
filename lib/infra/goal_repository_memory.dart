import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
// ignore: avoid_print

class GoalRepositoryMemory implements IGoalRepository {
  late List<Goal> goalsData;

  GoalRepositoryMemory() {
    goalsData = [];
  }

  @override
  void save(Goal goal) {
    // ignore: avoid_print
    print("SAVING NEW GOAL: ${goal.id}");
    goalsData.add(goal);
  }

  @override
  Future<List<Goal>> getAll() async {
    // ignore: avoid_print
    print("GETTING ALL");
    return goalsData;
  }

  @override
  void update(Goal goal) {
    // ignore: avoid_print
    print("UPDATING GOAL");
    var goalIndex = goalsData.indexWhere((data) => data.id == goal.id);
    goalsData[goalIndex] = goal;
  }

  @override
  Future<MainGoal> getById(String id) async {
    // ignore: avoid_print
    print("GETTING BY ID:$id");
    return goalsData.firstWhere((data) => data.id == id) as MainGoal;
  }
}
