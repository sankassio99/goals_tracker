import 'package:goals_tracker/domain/entities/deposit_entry.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainGoal extends Goal {
  List<SubGoal> subGoals = [];
  List<Task> tasks = [];
  List<DepositEntry>? depositEntries = [];

  PhosphorIconData? icon;
  DateTime? finalDate;
  String target;

  MainGoal(
    super.id,
    super.title,
    super.desc,
    this.target, {
    super.completePercentage,
    super.isCompleted,
    super.type,
    this.icon,
    this.depositEntries,
    List<Task>? taskList,
    this.finalDate,
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'target': target,
      'completePercentage': completePercentage,
      'isCompleted': isCompleted,
      'type': type.toString(),
      // 'icon': icon?.toJson(),
      'finalDate': finalDate?.toIso8601String(),
      'tasks': tasks.map((task) => task.toJson()).toList(),
      // 'depositEntries': depositEntries?.map((entry) => entry.toJson()).toList(),
    };
  }
}
