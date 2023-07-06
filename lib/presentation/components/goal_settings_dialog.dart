import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/presentation/components/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/icon_picker_dialog.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_meansure_type.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

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
                  color: Theme.of(context).colorScheme.onSecondary,
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
                          color: Theme.of(context).colorScheme.onSecondary),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownFormField extends StatelessWidget {
  final Rx<GoalMeansureType> goalTypeSelected;
  final List<GoalMeansureType> goalTypes;
  final Function(GoalMeansureType newType) onSelected;

  const DropdownFormField({
    super.key,
    required this.goalTypeSelected,
    required this.goalTypes,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
          child: Text(
            "Meansure Type",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        Obx(
          () => Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: DropdownButton(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              underline: Container(),
              enableFeedback: false,
              style: const TextStyle(),
              focusColor: Colors.transparent,
              value: goalTypeSelected.value.name,
              items: goalTypes
                  .map<DropdownMenuItem<String>>((GoalMeansureType type) {
                return DropdownMenuItem(
                  value: type.name,
                  child: Text(type.name),
                );
              }).toList(),
              onChanged: (String? goalType) {
                var selected =
                    goalTypes.firstWhereOrNull((type) => type.name == goalType);

                goalTypeSelected.value = selected!;

                onSelected(selected);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DateFormField extends StatelessWidget {
  final Rx<DateTime?> selectedDate;
  final Function(DateTime? date) onSelectDate;

  const DateFormField({
    super.key,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
          child: Text(
            "Final Countdown",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            selectedDate.value = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025));
            onSelectDate(selectedDate.value);
          },
          child: Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Obx(
              () => Text(dateToString(selectedDate.value)),
            ),
          ),
        ),
      ],
    );
  }

  dateToString(DateTime? value) {
    if (value != null) {
      return "${value.day}/${value.month}/${value.year}";
    }

    return "";
  }
}
