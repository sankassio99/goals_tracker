import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';

class GoalRepository implements IGoalRepository {
  late List<Goal> goalsData;

  GoalRepository() {
    goalsData = [];
  }

  @override
  void save(Goal goal) {
    print("SALVANDO AQUI");
    goalsData.add(goal);
  }

  @override
  Future<List<Goal>> getAll() async {
    print("BUSCANDO TODOS");
    return goalsData;
  }
}
