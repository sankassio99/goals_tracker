import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final GoalModel goalModel;

  const ProgressBar({
    super.key,
    required this.goalModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(
          () => LinearPercentIndicator(
            key: const Key("progressBar"),
            percent: goalModel.completeProgress.value,
            lineHeight: 24,
            animation: true,
            progressColor: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: Theme.of(context).colorScheme.background,
            center: Text(
              "${goalModel.completeProgress.value * 100}%",
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            barRadius: const Radius.circular(8),
            padding: const EdgeInsets.symmetric(vertical: 0.0),
          ),
        );
      },
    );
  }
}
