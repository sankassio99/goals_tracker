import 'package:goals_tracker/domain/entities/goal_types_enum.dart';

class GoalMeansureType {
  String? _name;
  final GoalType _type;

  GoalMeansureType(this._type) {
    if (_type == GoalType.tasks) _name = "Tasks";
    if (_type == GoalType.monetary) _name = "Monetary";
    if (_type == GoalType.days) _name = "Days";
  }

  String get name => _name!;
  GoalType get type => _type;
}
