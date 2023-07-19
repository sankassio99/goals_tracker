import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';

abstract class IGoalRepository {
  void save(Goal goal);
  Future<List<Goal>> getAll();
  Future<MainGoal> getById(String id);
  void update(Goal goal);
  void delete(String id);
}
