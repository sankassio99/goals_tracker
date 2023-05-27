import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';

class GetGoalDetails {
  IGoalRepository goalRepository;

  GetGoalDetails(this.goalRepository);

  Future<MainGoal> get(String id) async {
    var goal = goalRepository.getById(id);

    return goal;
  }
}
