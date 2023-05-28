import 'package:goals_tracker/domain/entities/sub_goal.dart';

abstract class ISubGoalRepository {
  void save(SubGoal goal);
  Future<List<SubGoal>> getAll();
  Future<List<SubGoal>> getByMainGoalId(String id);
  Future<SubGoal> getById(String id);
  void update(SubGoal goal);
}
