import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/update_goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'add_new_goal_test.mocks.dart';

@GenerateMocks([IGoalRepository])
void main() {
  late UpdateGoal updateGoal;
  late MockIGoalRepository goalRepositoryMock;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    updateGoal = UpdateGoal(goalRepositoryMock);
  });

  group('Update Goal use case should', () {
    test('update existing goal in repository', () async {
      //#region Arrange(Given)
      var goal = MainGoal("1", "Buy a car", "");
      //#endregion

      //#region Act(When)
      updateGoal.execute(goal);
      //#endregion

      //#region Assert
      var matcher = predicate<MainGoal>((value) {
        expect(value.id, goal.id);
        expect(value.title, goal.title);
        expect(value.desc, goal.desc);
        return true;
      });

      verify(goalRepositoryMock.update(captureThat(matcher))).called(1);
      //#endregion
    });
  });
}
