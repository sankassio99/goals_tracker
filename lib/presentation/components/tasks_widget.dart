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
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My tasks",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => Column(
                children: tasks
                    .asMap()
                    .map(
                      (int index, TaskModel task) => MapEntry(
                        index,
                        Dismissible(
                          key: Key(index.toString()),
                          onDismissed: (_) {},
                          child: CheckboxListTile(
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
                                  )),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            value: task.checked.value,
                            onChanged: (value) {
                              task.checked.value = value ?? false;
                              controller.onTaskCheck();
                            },
                            secondary: InkWell(
                              onTap: () {
                                controller.onDeleteTask(index);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text('Task deleted!'),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                ));
                              },
                              child: Icon(
                                key: const Key("taskItemIcon"),
                                PhosphorIcons.regular.trash,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
