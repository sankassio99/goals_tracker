import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

class MainGoal extends Goal {
  List<SubGoal> subGoals = [];

  MainGoal(
    this.subGoals,
    super.title,
    super.desc,
    super.completePercent,
    super.compleStutus,
  );

  @override
  int getCompletePercent() {
    // TODO: implement getCompletePercent
    throw UnimplementedError();
  }
}
