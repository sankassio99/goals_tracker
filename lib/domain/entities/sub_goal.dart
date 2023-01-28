import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';

class SubGoal extends Goal {
  List<Task> tasks;

  SubGoal(
    this.tasks,
    super.title,
    super.desc,
    super.completePercent,
    super.completeStutus,
  );

  @override
  int getCompletePercent() {
    // TODO: implement getCompletePercent
    throw UnimplementedError();
  }
}
