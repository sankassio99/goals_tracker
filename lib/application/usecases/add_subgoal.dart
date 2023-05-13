import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:uuid/uuid.dart';

class AddSubgoal {
  late final IGoalRepository _goalRepository;
  Uuid uuid = const Uuid();

  AddSubgoal(this._goalRepository);

  Future<String> execute(String mainGoalId) async {
    MainGoal mainGoal = await _goalRepository.getById(mainGoalId) as MainGoal;
    var uuidGenerated = uuid.v1().toString();
    var subGoal = SubGoal(uuidGenerated, "Tap to edit", "");

    mainGoal.addSubGoal(subGoal);

    _goalRepository.update(mainGoal);

    return uuidGenerated;
  }
}
