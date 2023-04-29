import 'package:goals_tracker/domain/entities/goal.dart';

import '../adapters/igoal_repository.dart';

class AddNewGoal {
  AddNewGoal(IGoalRepository goalRepository);

  String execute() {
    print("Creating a new goal");
    return "id-random";
  }
}
