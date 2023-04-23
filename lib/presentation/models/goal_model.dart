import 'package:flutter/material.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

class GoalModel {
  String id;
  TextEditingController name = TextEditingController(text: "");
  String description = "";
  List<SubGoal> subGoals = List.empty();

  GoalModel(this.id);
}
