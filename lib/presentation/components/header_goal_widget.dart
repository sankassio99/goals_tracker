import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/icon_picker_dialog.dart';
import 'package:goals_tracker/presentation/components/progress_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class HeaderGoalWidget extends StatelessWidget {
  final GoalModel model;
  final controller = Get.find<MainGoalController>();

  HeaderGoalWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: IconPickerDialog(
                          currentIcon: model.icon,
                        ),
                      ),
                      Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            controller.updateGoal();
                          }
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 40,
                          child: TextField(
                              maxLines: 1,
                              key: const Key("titleInput"),
                              controller: model.nameController,
                              decoration: const InputDecoration(
                                  hintText: 'Goal name',
                                  border: InputBorder.none),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Focus(
                    onFocusChange: (value) {
                      if (!value) {
                        controller.updateGoal();
                      }
                    },
                    child: TextField(
                        key: const Key("descInput"),
                        controller: model.descriptionController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: 'Tap to type goal description...',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ],
              ),
            ),
          ),
          ProgressBar(goalModel: model),
        ],
      ),
    );
  }
}
