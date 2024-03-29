import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/presentation/components/formFields/date_form_field.dart';
import 'package:goals_tracker/presentation/components/formFields/dropdown_form_field.dart';
import 'package:goals_tracker/presentation/components/formFields/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/icon_picker_dialog.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_meansure_type.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalSettingsDialog extends StatelessWidget {
  final GoalModel goalModel;
  final controller = Get.find<MainGoalController>();
  final Rx<String> selectedDateTime = "Select a date".obs;

  GoalSettingsDialog({
    required this.goalModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      key: const Key("settingsDialog"),
      child: Scaffold(
        appBar: MyAppBar(
          title: "Goals settings",
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            TextButton(
              key: const Key("readyEditing"),
              onPressed: () {
                controller.updateGoal();
                Navigator.pop(context);
              },
              child: Text(
                "READY",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Column(children: [
                    IconPickerDialog(
                      currentIcon: goalModel.icon,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Change Icon",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ]),
                ),
                FormFieldWidget(
                  key: const Key("goalName"),
                  label: "Name",
                  controller: goalModel.name,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 18,
                ),
                FormFieldWidget(
                  key: const Key("goalDescription"),
                  label: "Description",
                  controller: goalModel.description,
                ),
                const SizedBox(
                  height: 18,
                ),
                DateFormField(
                  key: const Key("goalFinalDate"),
                  label: "Final Countdown",
                  selectedDate: goalModel.finalDate.obs,
                  onSelectDate: goalModel.setFinalDate,
                ),
                const SizedBox(
                  height: 18,
                ),
                DropdownFormField(
                  goalTypeSelected: goalModel.meansureType.obs,
                  goalTypes: [
                    GoalMeansureType(GoalType.monetary),
                    GoalMeansureType(GoalType.tasks),
                    GoalMeansureType(GoalType.days),
                  ],
                  onSelected: goalModel.setMeansureType,
                ),
                const SizedBox(
                  height: 18,
                ),
                FormFieldWidget(
                  key: const Key("goalTarget"),
                  label: "Target",
                  controller: goalModel.target,
                  typeNumber: true,
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          TextButton(
            key: const Key("deleteGoalButton"),
            onPressed: () {
              controller.delete(goalModel.id);
              Get.toNamed("/home");
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.bold.trash,
                    size: 16,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                Text(
                  "Delete",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
