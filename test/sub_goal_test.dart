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
      var completePercentage = subGoal.getCompletePercentage();
      //#endregion

      //#region Assert(Then)
      expect(completePercentage, 0);
      //#endregion
    });

    test('get complete percent when has 2 completed tasks of 5', () async {
      //#region Arrange(Given)
      String subGoalTitle = "Learn english";
      String subGoalDesc = "";

      SubGoal subGoal = SubGoal(subGoalTitle, subGoalDesc);

      var task1 = Task("title");
      var task2 = Task("title");

      List<Task> tasks = [
        task1,
        task2,
        Task("title"),
        Task("title"),
        Task("title"),
      ];

      for (var task in tasks) {
        subGoal.addTask(task);
      }

      task1.markAsCompleted();
      task2.markAsCompleted();

      //#endregion

      //#region Act(When)
      var completePercentage = subGoal.getCompletePercentage();
      //#endregion

      //#region Assert(Then)
      expect(completePercentage, 40);
      //#endregion
    });
  });
}
