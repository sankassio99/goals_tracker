import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainGoalPageWidget extends StatelessWidget {
  final controller = Get.find<MainGoalController>();

  MainGoalPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getGoal();
    return GetBuilder<MainGoalController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: const MyAppBar(),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: 1000,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 213,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: HeaderGoalWidget(
                        model: controller.goalModel.value,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.black12,
                  ),
                  TasksWidget(tasks: controller.goalModel.value.tasks)
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key("addTaskButton"),
          child: const Icon(Icons.add),
          onPressed: () => controller.addTask(),
        ),
      );
    });
  }
}

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
