import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';

void main() {
  setUp(() async {});
  group('Sub Goal should', () {
    test('add new task and list all', () async {
      //#region Arrange(Given)
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);

      String title = "Group class";
      Task task = Task(title);
      //#endregion

      //#region Act(When)
      subGoal.addTask(task);
      //#endregion

      //#region Assert(Then)
      var actualSubGoals = subGoal.getTasks();
      expect(actualSubGoals.length, 1);
      //#endregion
    });

    test('get complete percent', () async {
      //#region Arrange(Given)
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);
      //#endregion

      //#region Act(When)
      var completePercent = subGoal.getCompletePercent();
      //#endregion

      //#region Assert(Then)
      expect(completePercent, 0);
      //#endregion
    });

    test('get complete percent when has 2 completed tasks of 5', () async {
      //#region Arrange(Given)
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);
      //#endregion

      //#region Act(When)
      var completePercent = subGoal.getCompletePercent();
      //#endregion

      //#region Assert(Then)
      expect(completePercent, 40);
      //#endregion
    });
  });
}
