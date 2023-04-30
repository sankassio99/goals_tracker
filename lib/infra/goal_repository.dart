import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class GoalRepositoryMemory implements IGoalRepository {
  late List<Goal> goalsData;

  GoalRepositoryMemory() {
    goalsData = [];
  }

  @override
  void save(Goal goal) {
    print("SAVING NEW GOAL");
    goalsData.add(goal);
  }

  @override
  Future<List<Goal>> getAll() async {
    print("GETTING ALL");
    return goalsData;
  }

  @override
  void update(Goal goal) {
    print("UPDATING GOAL");
    var goalIndex = goalsData.indexWhere((data) => data.id == goal.id);
    goalsData[goalIndex] = goal;
  }

  @override
  Future<Goal> getById(String id) async {
    print("GETTING BY ID");
    return goalsData.firstWhere((data) => data.id == id);
  }
}
