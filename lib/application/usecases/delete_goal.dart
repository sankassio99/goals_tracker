import 'package:goals_tracker/application/adapters/igoal_repository.dart';

class DeleteGoal {
  IGoalRepository goalRepository;

  DeleteGoal(this.goalRepository);

  void execute(String id) async {
    goalRepository.delete(id);
  }
}
