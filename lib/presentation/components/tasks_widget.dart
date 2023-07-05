import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TasksWidget extends StatelessWidget {
  final RxList<TaskModel> tasks;
  final RxBool editMode = false.obs;
  final controller = Get.find<MainGoalController>();

  TasksWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My tasks",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                key: const Key("editModeTasksButton"),
                onPressed: () {
                  editMode.value = !editMode.value;
                },
                child: Obx(
                  () => Text(
                    editMode.isTrue ? "Ok" : "Edit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => editMode.isTrue
                  ? ReorderableTaskList(
                      key: const Key("reorderTaskList"),
                      tasks: tasks,
                    )
                  : Column(
                      children: tasks
                          .map((TaskModel task) => CheckboxListTile(
                                title: Focus(
                                  onFocusChange: (value) {
                                    if (!value) controller.updateGoal();
                                  },
                                  child: TextFormField(
                                    key: const Key("inputTask"),
                                    controller: task.name,
                                    decoration: const InputDecoration(
                                      hintText: 'Tap to edit',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                value: task.checked.value,
                                onChanged: (value) {
                                  task.checked.value = value ?? false;
                                  controller.onTaskCheck();
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ))
                          .toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReorderableTaskList extends StatelessWidget {
  final RxList<TaskModel> tasks;
  final controller = Get.find<MainGoalController>();

  ReorderableTaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Obx(() => ReorderableListView(
          children: tasks
              .asMap()
              .map((int index, TaskModel task) => MapEntry(
                  index,
                  Container(
                    padding: const EdgeInsets.fromLTRB(4, 18, 18, 18),
                    margin: const EdgeInsets.fromLTRB(0, 2, 0, 4),
                    key: ValueKey(task.name.text),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.onDeleteTask(index);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Task deleted!'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                            ));
                          },
                          child: Icon(
                            key: const Key("trashTaskIcon"),
                            PhosphorIcons.regular.trash,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                          child: Text(task.name.text),
                        ),
                      ],
                    ),
                  )))
              .values
              .toList(),
          onReorder: (oldIndex, newIndex) {
            controller.reorderTasks(oldIndex, newIndex);
          })),
    );
  }
}
