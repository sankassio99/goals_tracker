import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/application/services/observable.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class UpdateGoal extends Observable {
  late IGoalRepository goalRepository;

  UpdateGoal(this.goalRepository);

  void execute(Goal goal) {
    goalRepository.update(goal);
    notify("updateGoal", null);
  }
}
