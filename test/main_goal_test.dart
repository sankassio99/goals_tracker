import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

void main() {
  setUp(() async {});
  group('Main Goal should', () {
    test('add new subgoal and list all goals', () async {
      //#region Arrange(Given)
      String title = "Get international job";
      String desc = "I need is motivated everyday";

      MainGoal mainGoal = MainGoal(title, desc);

      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);
      //#endregion

      //#region Act(When)
      mainGoal.addSubGoal(subGoal);
      //#endregion

      //#region Assert(Then)
      var actualSubGoals = mainGoal.getSubGoals();
      expect(actualSubGoals.length, 1);
      //#endregion
    });

    test('get complete percent', () async {
      //#region Arrange(Given)
      String title = "Get international job";
      String desc = "I need is motivated everyday";

      MainGoal mainGoal = MainGoal(title, desc);

      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);
      mainGoal.addSubGoal(subGoal);
      //#endregion

      //#region Act(When)
      var completePercent = mainGoal.getCompletePercent();
      //#endregion

      //#region Assert(Then)
      expect(completePercent, 0);
      //#endregion
    });
  });
}
