import 'package:flutter/material.dart';

class GoalModel {
  String id;
  final TextEditingController _name = TextEditingController(text: "");
  final TextEditingController _description = TextEditingController(text: "");
  List<GoalModel> subGoals = [];

  GoalModel(
    this.id, {
    String description = "",
    String name = "",
  }) {
    _name.text = name;
    _description.text = description;
  }

  addSubGoal() {
    print("addsubgoal in goal model");
  }

  setSubGoalList(List<GoalModel> subGoals) {
    this.subGoals = subGoals;
  }

  String get name => _name.text;
  set name(String name) => _name.text = name;
  TextEditingController get nameController => _name;

  String get description => _description.text;
  set description(String description) => _description.text = description;
  TextEditingController get descriptionController => _description;

  onInputFocusChange(bool value) {}
}
