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
  double getCompletePercent() {
    return calculatePercent();
  }

  double calculatePercent() {
    var subGoalsCompletePercent = 0.0;
    var subGoalsTotalPercent = 0.0;

    if (subGoals.isNotEmpty) {
      subGoalsTotalPercent = subGoals.length * 100;

      for (var subGoal in subGoals) {
        subGoalsCompletePercent += subGoal.completePercent;
      }

      completePercent =
          ((subGoalsCompletePercent / subGoalsTotalPercent) * 100);
    }
    return completePercent;
  }

  void addSubGoal(SubGoal subGoal) {
    subGoals.add(subGoal);
  }

  List<SubGoal> getSubGoals() {
    return subGoals;
  }
}
