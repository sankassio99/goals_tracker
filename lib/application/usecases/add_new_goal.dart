import 'package:goals_tracker/domain/entities/goal.dart';

class AddNewGoal {
  AddNewGoal();

  String execute() {
    print("Creating a new goal");
    return "id-random";
  }
}
