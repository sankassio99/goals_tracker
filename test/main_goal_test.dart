import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

void main() {
  setUp(() async {});
  group('Main Goal should', () {
    test('add new subgoal and list all goals', () async {
      //#region Arrange(Given)
      List<SubGoal> subGoals = [];
      String title = "Get international job";
      String desc = "I need is motivated everyday";
      int completePercent = 0;
      bool completeStutus = false;

      MainGoal mainGoal =
          MainGoal(subGoals, title, desc, completePercent, completeStutus);

      String subGoalTitle = "Learn english";
      String subGoalDesc = "";
      int subGoalCompletePercent = 0;
      bool subGoalCompleteStutus = false;

      SubGoal subGoal = SubGoal([], subGoalTitle, subGoalDesc,
          subGoalCompletePercent, subGoalCompleteStutus);
      //#endregion

      //#region Act(When)
      mainGoal.addSubGoal(subGoal);
      //#endregion

      //#region Assert(Then)
      var actualSubGoals = mainGoal.getSubGoals();
      expect(actualSubGoals.length, 1);
      //#endregion
    });
  });
}
