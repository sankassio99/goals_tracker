import 'package:flutter_test/flutter_test.dart';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/usecases/get_goal_details.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_goals_test.mocks.dart';

@GenerateMocks([IGoalRepository])
void main() {
  late GetGoalDetails getGoalDetails;
  late MockIGoalRepository goalRepositoryMock;

  setUp(() async {
    goalRepositoryMock = MockIGoalRepository();
    getGoalDetails = GetGoalDetails(goalRepositoryMock);
  });

  group('Get Goal Details usecase should', () {
    test('get goal details by id saved on repository', () async {
      //#region Arrange(Given)
      var myGoal = MainGoal("1", "Buy a car", "", "100");
      goalRepositoryMock.save(myGoal);

      when(goalRepositoryMock.getById(myGoal.id))
          .thenAnswer((_) async => myGoal);
      //#endregion

      //#region Act(When)
      var actualGoal = await getGoalDetails.get(myGoal.id);
      //#endregion

      //#region Assert(Then)
      expect(actualGoal.id, myGoal.id);
      expect(actualGoal.title, myGoal.title);
      expect(actualGoal.desc, myGoal.desc);
      //#endregion
    });
  });
}
