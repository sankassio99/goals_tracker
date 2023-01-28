import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

class MainGoal extends Goal {
  List<SubGoal> subGoals = [];

  MainGoal(
    super.title,
    super.desc, {
    super.completePercent,
    super.completeStutus,
  });

  @override
  int getCompletePercent() {
    // TODO: implement getCompletePercent
    throw UnimplementedError();
  }

  void addSubGoal(SubGoal subGoal) {
    subGoals.add(subGoal);
  }

  List<SubGoal> getSubGoals() {
    return subGoals;
  }
}
