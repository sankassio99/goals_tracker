import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Column(
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
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
                      child: Icon(
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                    Focus(
                      onFocusChange: (value) {
                        if (!value) {
                          controller.updateGoal();
                        }
                      },
                      child: SizedBox(
                        width: 300,
                        height: 40,
                        child: TextField(
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
                  onFocusChange: (value) {},
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
        const ProgressBar(),
      ],
    );
  }
}
