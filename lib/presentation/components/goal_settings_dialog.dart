import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/icon_picker_dialog.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalSettingsDialog extends StatelessWidget {
  final GoalModel goalModel;

  const GoalSettingsDialog({
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
              onPressed: () {
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
        body: Padding(
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
                    currentIcon: PhosphorIcons.bold.airplane.obs,
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
                controller: goalModel.nameController,
              ),
              const SizedBox(
                height: 18,
              ),
              FormFieldWidget(
                key: const Key("goalDescription"),
                label: "Description",
                controller: goalModel.descriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
