import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TasksWidget extends StatelessWidget {
  final RxList<TaskModel> tasks;
  final controller = Get.find<MainGoalController>();

  TasksWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => Column(
            children: tasks
                .map(
                  (TaskModel task) => CheckboxListTile(
                    title: Focus(
                      onFocusChange: (value) {
                        if (!value) controller.updateGoal();
                      },
                      child: TextField(
                          key: const Key("inputTask"),
                          controller: task.name,
                          decoration: const InputDecoration(
                              hintText: '', border: InputBorder.none)),
                    ),
                    value: task.checked.value,
                    onChanged: (value) {
                      task.checked.value = value ?? false;
                      controller.onTaskCheck();
                    },
                    secondary: Icon(
                      key: const Key("taskItemIcon"),
                      PhosphorIcons.regular.trash,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                )
                .toList(),
          )),
    );
  }
}
