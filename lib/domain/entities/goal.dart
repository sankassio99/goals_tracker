import 'package:goals_tracker/domain/entities/goal_types_enum.dart';

abstract class Goal {
  String id;
  String title;
  String desc;
  double completePercentage;
  bool isCompleted;
  GoalType type = GoalType.tasks;

  Goal(
    this.id,
    this.title,
    this.desc, {
    this.completePercentage = 0,
    this.isCompleted = false,
  });

  double getCompletePercentage();
}
