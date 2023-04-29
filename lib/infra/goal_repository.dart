import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class GoalRepository implements IGoalRepository {
  List<Goal> goalsData = List.empty();

  @override
  void save(Goal goal) {
    goalsData.add(goal);
  }
}
