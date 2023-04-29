import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:uuid/uuid.dart';

import '../adapters/igoal_repository.dart';

class AddNewGoal {
  late IGoalRepository goalRepository;
  AddNewGoal(this.goalRepository);

  String execute() {
    var uuid = const Uuid().v4.toString();
    var emptyGoal = MainGoal(uuid, "", "");
    goalRepository.save(emptyGoal);
    return uuid;
  }
}
