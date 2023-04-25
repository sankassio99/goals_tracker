import 'package:flutter/material.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';

class GoalModel {
  String id;
  final TextEditingController _name = TextEditingController(text: "");
  String description = "";
  List<SubGoal> subGoals = List.empty();

  GoalModel(this.id, {this.description = "", String title = ""}) {
    _name.text = title;
  }

  String get name => _name.text;
  set name(String name) => _name.text = name;
  TextEditingController get nameController => _name;
}
