import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

void main() {
  setUp(() async {});
  group('Sub Goal should', () {
    test('add new task and list all', () async {
      //#region Arrange(Given)
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);
      //#endregion

      //#region Act(When)
      subGoal.addTask();
      //#endregion

      //#region Assert(Then)
      var actualSubGoals = subGoal.getTasks();
      expect(actualSubGoals.length, 1);
      //#endregion
    });
  });
}
