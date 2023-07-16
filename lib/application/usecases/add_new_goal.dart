import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:uuid/uuid.dart';

import '../adapters/igoal_repository.dart';

class AddNewGoal {
  late IGoalRepository goalRepository;
  Uuid uuid = const Uuid();

  AddNewGoal(this.goalRepository);

  String execute() {
    var uuidGenerated = uuid.v1().toString();
    var emptyGoal = MainGoal(uuidGenerated, "", "", "100");

    goalRepository.save(emptyGoal);

    return uuidGenerated;
  }

  String create(String name, String target, GoalType type) {
    var uuidGenerated = uuid.v1().toString();
    var newGoal = MainGoal(uuidGenerated, name, "", target, type: type);

    goalRepository.save(newGoal);

    return uuidGenerated;
  }
}
