import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/goal_type_tag.dart';
import 'package:goals_tracker/presentation/components/icon_picker_dialog.dart';
import 'package:goals_tracker/presentation/components/progress_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      height: 200,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: GoalTitleWidget(model: model, controller: controller)),
            Expanded(
              flex: 1,
              child: GoalTypeTag(model: model),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 3,
              child: ProgressBarBox(model: model),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressBarBox extends StatelessWidget {
  final controller = Get.find<MainGoalController>();

  ProgressBarBox({
    super.key,
    required this.model,
  });

  final GoalModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.finalDate != null
              ? DaysCountdown(controller: controller)
              : Container(),
          const SizedBox(
            height: 8,
          ),
          ProgressBar(goalModel: model),
        ],
      ),
    );
  }
}

class DaysCountdown extends StatelessWidget {
  const DaysCountdown({
    super.key,
    required this.controller,
  });

  final MainGoalController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Icon(
          PhosphorIcons.bold.clockCountdown,
          size: 16,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: Text(
            "${controller.getLeftDays(DateTime.now())} days",
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          width: 42,
          height: 48,
          alignment: AlignmentDirectional.bottomStart,
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
            // child: Text(
            //   key: const Key("titleInput"),
            //   model.name.text,
            //   style: const TextStyle(
            //     color: Colors.black87,
            //     fontSize: 24,
            //     fontWeight: FontWeight.w800,
            //   ),
            // ),
            child: TextField(
                maxLines: 1,
                key: const Key("titleInput"),
                controller: model.name,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: 'Goal name',
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ),
      ],
    );
  }
}
