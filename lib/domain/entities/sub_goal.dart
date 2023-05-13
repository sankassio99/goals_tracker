import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';

class SubGoal extends Goal {
  String mainGoalId;
  List<Task> tasks = [];

  SubGoal(
    super.id,
    super.title,
    this.mainGoalId,
    super.desc, {
    super.completePercentage,
    super.isCompleted,
  });

  @override
  double getCompletePercentage() {
    _calculatePercentage();
    return completePercentage;
  }

  void _calculatePercentage() {
    var completedTasks = 0;

    if (tasks.isNotEmpty) {
      for (var task in tasks) {
        if (task.completeStatus) {
          completedTasks++;
        }
      }
      completePercentage = ((completedTasks / tasks.length) * 100);
    }
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  List<Task> getTasks() {
    return tasks;
  }
}
