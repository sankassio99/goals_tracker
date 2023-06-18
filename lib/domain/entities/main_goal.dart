import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainGoal extends Goal {
  List<SubGoal> subGoals = [];
  List<Task> tasks = [];
  PhosphorIconData? icon;

  MainGoal(
    super.id,
    super.title,
    super.desc, {
    super.completePercentage,
    super.isCompleted,
    this.icon,
    List<Task>? taskList,
  }) : tasks = taskList ?? [];

  @override
  double getCompletePercentage() {
    _calculatePercent();
    return completePercentage;
  }

  void _calculatePercent() {
    var subGoalsCompletePercent = 0.0;
    var subGoalsTotalPercent = 0.0;

    if (subGoals.isNotEmpty) {
      subGoalsTotalPercent = subGoals.length * 100;

      for (var subGoal in subGoals) {
        subGoalsCompletePercent += subGoal.completePercentage;
      }

      completePercentage =
          ((subGoalsCompletePercent / subGoalsTotalPercent) * 100);
    }
  }

  void addSubGoal(SubGoal subGoal) {
    subGoals.add(subGoal);
  }

  List<SubGoal> getSubGoals() {
    return subGoals;
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  List<Task> getTasks() {
    return tasks;
  }
}
