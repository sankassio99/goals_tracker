import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class GetGoals {
  GetGoals(IGoalRepository goalRepositoryMock);

  List<Goal> getAll() {
    print("Listing all goals");
    return List.empty();
  }
}
