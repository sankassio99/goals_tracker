import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class UpdateGoal {
  late IGoalRepository goalRepository;

  UpdateGoal(this.goalRepository);

  void execute(Goal goal) {
    print("Updating goal: " + goal.id);
  }
}
