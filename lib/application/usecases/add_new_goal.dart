import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:uuid/uuid.dart';

import '../adapters/igoal_repository.dart';

class AddNewGoal {
  late IGoalRepository goalRepository;
  Uuid uuid = const Uuid();

  AddNewGoal(this.goalRepository);

  String execute() {
    var uuidGenerated = uuid.v1().toString();
    var emptyGoal = MainGoal(uuidGenerated, "", "");
    goalRepository.save(emptyGoal);

    return uuidGenerated;
  }
}
