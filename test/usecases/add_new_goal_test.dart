import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/add_new_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../add_new_goal_test.mocks.dart';

@GenerateMocks([IGoalRepository])
void main() {
  late AddNewGoal addNewGoal;
  late MockIGoalRepository goalRepositoryMock;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    addNewGoal = AddNewGoal(goalRepositoryMock);
  });

  group('Add new goal use cases should', () {
    test('create a new goal and save on repository', () async {
      //#region Arrange(Given)
      //#endregion

      //#region Act(When)
      var goalId = addNewGoal.execute();
      //#endregion

      //#region Assert(Then)
      expect(goalId, isNotNull);
      verify(goalRepositoryMock.save(any)).called(1);
      //#endregion
    });
  });
}
