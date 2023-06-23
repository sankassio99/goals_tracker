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
          actions: [
            IconButton(
              key: const Key("goalSettings"),
              icon: Icon(
                PhosphorIcons.regular.gear,
                color: Colors.black87,
              ),
              tooltip: 'Edit',
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => const GoalSettingsDialog(),
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

class GoalSettingsDialog extends StatelessWidget {
  const GoalSettingsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      key: const Key("settingsDialog"),
      child: Scaffold(
        appBar: MyAppBar(
          title: "Goals settings",
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "READY",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        // ignore: prefer_const_constructors
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
          child: Text(
            'Name',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        TextField(
          key: Key("titleInput"),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSecondary, width: 3.0),
              borderRadius: BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
