import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';

class GoalModel {
  String id;
  final TextEditingController _name = TextEditingController(text: "");
  final TextEditingController _description = TextEditingController(text: "");
  List<GoalModel> subGoals = [];
  RxList<TaskModel> tasks = RxList<TaskModel>();

  GoalModel(
    this.id, {
    String description = "",
    String name = "",
  }) {
    _name.text = name;
    _description.text = description;
  }

  addSubGoal(GoalModel subGoal) {
    subGoals.add(subGoal);
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

  Goal toMainGoalEntity() {
    return MainGoal(id, name, description);
  }

  void addTask() {
    tasks.add(TaskModel("Tap to edit"));
  }
}

class TaskModel {
  String name;
  bool checked = false;
  Icon icon = const Icon(Icons.task_alt);

  TaskModel(this.name);
}
