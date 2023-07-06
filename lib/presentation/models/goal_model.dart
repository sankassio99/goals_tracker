import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:goals_tracker/presentation/models/task_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalModel {
  String id;
  final TextEditingController name = TextEditingController(text: "");
  final TextEditingController description = TextEditingController(text: "");
  RxList<TaskModel> tasks = RxList<TaskModel>();
  RxDouble completePercentage = 0.0.obs;
  Rx<PhosphorIconData> icon =
      Rx<PhosphorIconData>(PhosphorIcons.fill.notePencil);
  DateTime? finalDate;
  GoalType meansureType;

  GoalModel(
    this.id, {
    this.meansureType = GoalType.tasks,
    String description = "",
    String name = "",
    List<TaskModel>? taskList,
    double? progress,
    PhosphorIconData? iconData,
    this.finalDate,
  }) {
    this.name.text = name;
    this.description.text = description;
    tasks.value = taskList ?? [];
    completePercentage.value = progress ?? 0;
    icon.value = iconData ?? PhosphorIcons.fill.notePencil;
  }

  setFinalDate(DateTime? date) => finalDate = date;

  void addTask() {
    tasks.add(TaskModel(""));
  }

  static toModel(MainGoal goal) {
    List<TaskModel> tasks = _mapToTaskModelList(goal.tasks);

    return GoalModel(
      goal.id,
      description: goal.desc,
      name: goal.title,
      taskList: tasks,
      progress: goal.completePercentage,
      iconData: goal.icon,
      finalDate: goal.finalDate,
      meansureType: goal.type,
    );
  }

  static List<TaskModel> _mapToTaskModelList(List<Task> tasks) {
    List<TaskModel> newTasks = [];
    for (var task in tasks) {
      newTasks.add(TaskModel.toModel(task));
    }
    return newTasks;
  }

  Goal toMainGoalEntity() {
    var tasks = _mapToTaskListEntity();
    return MainGoal(
      id,
      name.text,
      description.text,
      taskList: tasks,
      completePercentage: completePercentage.value,
      icon: icon.value,
      finalDate: finalDate,
      type: meansureType,
    );
  }

  List<Task> _mapToTaskListEntity() {
    List<Task> newTasks = [];
    for (var task in tasks) {
      newTasks.add(task.toTaskEntity());
    }
    return newTasks;
  }

  void updateProgress() {
    var checkedTasks = _countCheckedTasks();
    var progress = (checkedTasks / tasks.length).toStringAsFixed(2);
    completePercentage.value = double.parse(progress);
  }

  int _countCheckedTasks() {
    var checkedTasks = 0;
    for (var task in tasks) {
      if (task.checked.isTrue) checkedTasks++;
    }
    return checkedTasks;
  }

  void changeIcon(Rx<PhosphorIconData> icon) {
    this.icon.value = icon.value;
  }
}
