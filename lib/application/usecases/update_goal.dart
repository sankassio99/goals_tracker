import 'package:goals_tracker/domain/entities/goal.dart';

class UpdateGoal {
  execute(Goal goal) {
    print("Updating goal: " + goal.id);
  }
}
