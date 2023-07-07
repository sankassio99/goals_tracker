import 'dart:convert';
import 'dart:html';
import 'package:goals_tracker/application/adapters/igoal_repository.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
// ignore: avoid_print

class GoalRepositoryStorage implements IGoalRepository {
  final Storage _localStorage = window.localStorage;

  GoalRepositoryStorage();

  @override
  void save(Goal goal) {
    // ignore: avoid_print
    print("SAVING NEW GOAL ON STORAGE: ${goal.id}");
    _localStorage[goal.id.toString()] = jsonEncode(goal.toJson());
  }

  @override
  Future<List<Goal>> getAll() async {
    // ignore: avoid_print
    print("GETTING ALL ON STORAGE");
    List<Goal> goalsData = [];

    var goalListStorage = _localStorage.values.toList();

    for (var goalString in goalListStorage) {
      MainGoal myGoal = MainGoal.fromJson(jsonDecode(goalString));
      goalsData.add(myGoal);
    }

    return goalsData;
  }

  @override
  void update(Goal goal) {
    // ignore: avoid_print
    print("UPDATING GOAL ON STORAGE ${goal.id}");
    _localStorage[goal.id.toString()] = jsonEncode(goal.toJson());
  }

  @override
  Future<MainGoal> getById(String id) async {
    // ignore: avoid_print
    print("GETTING BY ID ON STORAGE: $id");

    var goalStorage = _localStorage[id.toString()];
    var goalJson = jsonDecode(goalStorage!);
    MainGoal myGoal = MainGoal.fromJson(goalJson);
    return myGoal;
  }
}
