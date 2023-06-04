import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

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
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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

  const TasksWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 400,
      child: SingleChildScrollView(
        child: Obx(() => Column(
              children: tasks
                  .map(
                    (task) => CheckboxListTile(
                      title: Text(task.name),
                      value: task.checked.value,
                      onChanged: (value) {
                        task.checked.value = value ?? false;
                      },
                      secondary: const Icon(Icons.task_alt),
                    ),
                  )
                  .toList(),
            )),
      ),
    );
  }
}
