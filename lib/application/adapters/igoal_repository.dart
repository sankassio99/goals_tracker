import 'package:goals_tracker/domain/entities/goal.dart';

abstract class IGoalRepository {
  void save(Goal goal);
}
