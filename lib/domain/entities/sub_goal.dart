import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';

class SubGoal extends Goal {
  List<Task> tasks = [];

  SubGoal(
    super.title,
    super.desc, {
    super.completePercent,
    super.completeStutus,
  });

  @override
  double getCompletePercent() {
    double completePercent = 0;
    var completedTasks = 0;

    if (tasks.isNotEmpty) {
      for (var task in tasks) {
        if (task.completeStatus) {
          completedTasks++;
        }
      }
      completePercent = ((completedTasks / tasks.length) * 100);
    }

    return completePercent;
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  List<Task> getTasks() {
    return tasks;
  }
}
