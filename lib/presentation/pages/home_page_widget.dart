import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/formFields/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/components/goal_settings_dialog.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../components/bottom_button.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    controller.loadGoals();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 24, 8.0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
                  child: Text(
                    "Your Goals",
                    key: const Key("homeTitle"),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: controller.goalList
                              .map((goalModel) =>
                                  GoalCardWidget(model: goalModel))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          key: const Key("dialogAddGoal"),
          label: "ADD GOAL",
          action: () => showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.background,
            context: context,
            builder: (BuildContext context) => AddGoalDialog(),
          ),
        ),
      ],
    );
  }
}

class AddGoalDialog extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final GoalModel goalModel = GoalModel("", "");

  AddGoalDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        key: const Key("addGoalDialog"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Goal",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            FormFieldWidget(
              key: const Key("goalName"),
              label: "Name",
              controller: goalModel.name,
              maxLines: 1,
            ),
            FormFieldWidget(
              key: const Key("goalTarget"),
              label: "Target",
              controller: goalModel.target,
              maxLines: 1,
              typeNumber: true,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                key: const Key("addGoalButton"),
                child: const Text("Add goal"),
                onPressed: () {
                  controller.addNewGoal();
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
