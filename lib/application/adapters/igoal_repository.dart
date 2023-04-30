import 'package:goals_tracker/domain/entities/goal.dart';

abstract class IGoalRepository {
  void save(Goal goal);
  Future<List<Goal>> getAll();
  Future<Goal> getById(String id);
  void update(Goal goal);
}
