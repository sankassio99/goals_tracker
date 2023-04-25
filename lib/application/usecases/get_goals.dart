import 'package:goals_tracker/domain/entities/goal.dart';

class GetGoals {
  GetGoals();

  List<Goal> execute() {
    print("Listing all goals");
    return List.empty();
  }
}
