import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

void main() {
  setUp(() async {});
  group('Main Goal should', () {
    test('add new subgoal and list all', () async {
      //#region Arrange(Given)
      String title = "Get international job";
      String desc = "I need is motivated everyday";

      String mainGoalId = "random";
      MainGoal mainGoal = MainGoal(mainGoalId, title, desc);

      String id = "random";
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(id, subGoalTitle, subGoalDesc);
      //#endregion

      //#region Act(When)
      mainGoal.addSubGoal(subGoal);
      //#endregion

      //#region Assert(Then)
      var actualSubGoals = mainGoal.getSubGoals();
      expect(actualSubGoals.length, 1);
      //#endregion
    });

    test('get complete percent by subgoals percent', () async {
      //#region Arrange(Given)
      String title = "Get international job";
      String desc = "I need is motivated everyday";

      String mainGoalId = "random";
      MainGoal mainGoal = MainGoal(mainGoalId, title, desc);

      String subGoalId = "random";
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal1 = SubGoal(subGoalId, subGoalTitle, subGoalDesc);
      subGoal1.completePercentage = 50.0;
      mainGoal.addSubGoal(subGoal1);

      String subGoal2Id = "random";
      SubGoal subGoal2 = SubGoal(subGoal2Id, subGoalTitle, subGoalDesc);
      subGoal2.completePercentage = 10.0;
      mainGoal.addSubGoal(subGoal2);
      //#endregion

      //#region Act(When)
      var completePercentage = mainGoal.getCompletePercentage();
      //#endregion

      //#region Assert(Then)
      expect(completePercentage, 30);
      //#endregion
    });
  });
}
