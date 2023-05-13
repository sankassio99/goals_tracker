import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/add_subgoal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'add_new_goal_test.mocks.dart';

@GenerateMocks([IGoalRepository])
void main() {
  late AddSubgoal addSubgoal;
  late MockIGoalRepository goalRepositoryMock;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    addSubgoal = AddSubgoal(goalRepositoryMock);
  });

  group('Add sub goal use cases should', () {
    test('create a empty sub goal, add in goal and save on repository',
        () async {
      //#region Arrange(Given)
      String mainGoalId = "111100000";
      var mainGoal = MainGoal(
        mainGoalId,
        "Get international job",
        "I need is motivated everyday",
      );
      when(goalRepositoryMock.getById(mainGoalId))
          .thenAnswer((_) async => mainGoal);
      //#endregion

      //#region Act(When)
      addSubgoal.execute(mainGoalId);
      //#endregion

      //#region Assert(Then)
      var matcher = predicate<MainGoal>((savedGoal) {
        expect(savedGoal.id, mainGoal.id);
        expect(savedGoal.subGoals.length, 1);
        return true;
      });

      verify(goalRepositoryMock.save(captureThat(matcher))).called(1);
      //#endregion
    });
  });
}
