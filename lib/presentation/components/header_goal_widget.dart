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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 213,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 1,
                child: GoalTitleWidget(model: model, controller: controller)),
            Expanded(
                flex: 3,
                child: GoalDescWidget(controller: controller, model: model)),
            Expanded(flex: 1, child: ProgressBar(goalModel: model)),
          ],
        ),
      ),
    );
  }
}

class GoalDescWidget extends StatelessWidget {
  const GoalDescWidget({
    super.key,
    required this.controller,
    required this.model,
  });

  final MainGoalController controller;
  final GoalModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Focus(
        onFocusChange: (value) {
          if (!value) {
            controller.updateGoal();
          }
        },
        child: TextField(
            key: const Key("descInput"),
            controller: model.description,
            maxLines: null,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              hintText: 'Tap to type goal description...',
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            )),
      ),
    );
  }
}

class GoalTitleWidget extends StatelessWidget {
  const GoalTitleWidget({
    super.key,
    required this.model,
    required this.controller,
  });

  final GoalModel model;
  final MainGoalController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 48,
          alignment: AlignmentDirectional.centerStart,
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
            child: Text(
              model.name.text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            // TextField(
            //     maxLines: 1,
            //     key: const Key("titleInput"),
            //     controller: model.name,
            //     textAlignVertical: TextAlignVertical.center,
            //     decoration: const InputDecoration(
            //       contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 11),
            //       hintText: 'Goal name',
            //       border: InputBorder.none,
            //     ),
            //     style: const TextStyle(
            //       color: Colors.black87,
            //       fontSize: 24,
            //       fontWeight: FontWeight.w800,
            //     )),
          ),
        ),
      ],
    );
  }
}
