import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/isub_goal_repository.dart';
import 'package:goals_tracker/application/usecases/get_sub_goals.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'add_sub_goal_test.mocks.dart';

@GenerateMocks([ISubGoalRepository])
void main() {
  late GetSubGoals getSubGoals;
  late MockISubGoalRepository subGoalRepositoryMock;

  setUp(() async {
    subGoalRepositoryMock = MockISubGoalRepository();
    getSubGoals = GetSubGoals(subGoalRepositoryMock);
  });

  group('Get Sub Goals use case should', () {
    test('get sub goals by main goal id saved on repository', () async {
      //#region Arrange(Given)
      var mainGoalId = "11111111";
      var goal1 = SubGoal("1", "Buy a car", mainGoalId, "");
      var goal2 = SubGoal("2", "Build muscles", mainGoalId, "");
      subGoalRepositoryMock.save(goal1);
      subGoalRepositoryMock.save(goal2);

      List<SubGoal> goalList = [goal1, goal2];
      // when(subGoalRepositoryMock.getAllByMainGoalId(mainGoalId))
      //     .thenAnswer((_) async => goalList);
      //#endregion

      //#region Act(When)
      var goals = await getSubGoals.getAllByMainGoal(mainGoalId);
      //#endregion

      //#region Assert(Then)
      expect(goals.length, 2);
      expect(goals.first.id, goal1.id);
      expect(goals.last.id, goal2.id);
      //#endregion
    });
  });
}
