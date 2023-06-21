import 'package:goals_tracker/application/adapters/isub_goal_repository.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:uuid/uuid.dart';

class AddSubgoal {
  late final ISubGoalRepository _goalRepository;
  Uuid uuid = const Uuid();

  AddSubgoal(this._goalRepository);

  Future<String> execute(String mainGoalId) async {
    var uuidGenerated = uuid.v1().toString();
    var subGoal = SubGoal(uuidGenerated, "", mainGoalId, "");

    _goalRepository.save(subGoal);

    return uuidGenerated;
  }
}
