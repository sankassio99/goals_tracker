import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/isub_goal_repository.dart';
import 'package:goals_tracker/application/usecases/add_subgoal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'add_sub_goal_test.mocks.dart';

@GenerateMocks([ISubGoalRepository])
void main() {
  late AddSubgoal addSubgoal;
  late MockISubGoalRepository goalRepositoryMock;

  setUp(() async {
    goalRepositoryMock = MockISubGoalRepository();
    addSubgoal = AddSubgoal(goalRepositoryMock);
  });

  group('Add sub goal use cases should', () {
    test('create a empty sub goal, add in goal and save on repository',
        () async {
      //#region Arrange(Given)
      String mainGoalId = "111100000";
      //#endregion

      //#region Act(When)
      var subGoalId = await addSubgoal.execute(mainGoalId);
      //#endregion

      //#region Assert(Then)
      expect(subGoalId, isNotNull);

      var matcher = predicate<SubGoal>((savedGoal) {
        expect(savedGoal.mainGoalId, mainGoalId);
        return true;
      });

      verify(goalRepositoryMock.save(captureThat(matcher))).called(1);
      //#endregion
    });
  });
}
