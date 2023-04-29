import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class GetGoals {
  IGoalRepository goalRepository;

  GetGoals(this.goalRepository);

  Future<List<Goal>> getAll() async {
    var goals = await goalRepository.getAll();
    return goals;
  }
}
