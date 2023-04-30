import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';

class GetGoalDetails {
  IGoalRepository goalRepository;

  GetGoalDetails(this.goalRepository);

  Future<Goal> get(String id) async {
    return MainGoal(id, "title", " desc");
  }
}
