import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/task.dart';

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
