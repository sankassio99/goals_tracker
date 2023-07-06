import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalModel {
  String id;
  final TextEditingController _name = TextEditingController(text: "");
  final TextEditingController _description = TextEditingController(text: "");
  List<GoalModel> subGoals = [];
  RxList<TaskModel> tasks = RxList<TaskModel>();
  RxDouble completePercentage = 0.0.obs;
  Rx<PhosphorIconData> icon =
      Rx<PhosphorIconData>(PhosphorIcons.fill.notePencil);
  DateTime? finalDate;

  GoalModel(
    this.id, {
    String description = "",
    String name = "",
    List<TaskModel>? taskList,
    double? progress,
    PhosphorIconData? iconData,
    this.finalDate,
  }) {
    _name.text = name;
    _description.text = description;
    tasks.value = taskList ?? [];
    completePercentage.value = progress ?? 0;
    icon.value = iconData ?? PhosphorIcons.fill.notePencil;
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

  void addTask() {
    tasks.add(TaskModel(""));
  }

  static toModel(MainGoal goal) {
    List<TaskModel> tasks = _mapToTaskModelList(goal.tasks);

    return GoalModel(goal.id,
        description: goal.desc,
        name: goal.title,
        taskList: tasks,
        progress: goal.completePercentage,
        iconData: goal.icon);
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
      name,
      description,
      taskList: tasks,
      completePercentage: completePercentage.value,
      icon: icon.value,
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

class TaskModel {
  final TextEditingController name = TextEditingController(text: "");
  RxBool checked = false.obs;
  Icon icon = const Icon(Icons.task_alt);

  TaskModel(String name, {bool? isChecked}) {
    this.name.text = name;
    checked.value = isChecked ?? false;
  }

  static toModel(Task task) {
    return TaskModel(task.title, isChecked: task.isCompleted);
  }

  Task toTaskEntity() {
    return Task(name.text, isCompleted: checked.value);
  }
}
