import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/components/tasks_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
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
        appBar: MyAppBar(
          widget: [
            IconButton(
              key: const Key("goalSettings"),
              icon: Icon(
                PhosphorIcons.regular.gear,
                color: Colors.white,
              ),
              tooltip: 'Edit',
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dialog.fullscreen(
                  key: const Key("settingsDialog"),
                  child: Column(
                    children: [
                      const Text('This is a fullscreen dialog.'),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
