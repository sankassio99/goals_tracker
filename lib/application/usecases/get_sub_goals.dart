import 'package:goals_tracker/application/adapters/isub_goal_repository.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

class GetSubGoals {
  ISubGoalRepository subGoalRepository;

  GetSubGoals(this.subGoalRepository);

  Future<List<SubGoal>> getAllByMainGoal(String mainGoalId) async {
    var goals = await subGoalRepository.getAll();

    return goals;
  }
}
