import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/get_goals.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_goals_test.mocks.dart';

@GenerateMocks([IGoalRepository])
void main() {
  late GetGoals getGoals;
  late MockIGoalRepository goalRepositoryMock;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    getGoals = GetGoals(goalRepositoryMock);
  });

  group('Get Goals use case should', () {
    test('get all goals saved on repository', () async {
      //#region Arrange(Given)
      var goal1 = MainGoal("1", "Buy a car", "", "100");
      var goal2 = MainGoal("2", "Build muscles", "", "100");
      goalRepositoryMock.save(goal1);
      goalRepositoryMock.save(goal2);

      List<Goal> goalList = [goal1, goal2];
      when(goalRepositoryMock.getAll()).thenAnswer((_) async => goalList);
      //#endregion

      //#region Act(When)
      var goals = await getGoals.getAll();
      //#endregion

      //#region Assert(Then)
      expect(goals.length, 2);
      expect(goals.first.id, goal1.id);
      expect(goals.last.id, goal2.id);
      //#endregion
    });
  });
}
