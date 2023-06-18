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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          print(constraints.maxWidth);
          return Obx(
            () => LinearPercentIndicator(
              key: const Key("progressBar"),
              percent: goalModel.completePercentage.value,
              width: constraints.maxWidth == double.infinity
                  ? 100.0
                  : constraints.maxWidth - 20,
              lineHeight: 24,
              animation: true,
              progressColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.background,
              center: Text(
                (goalModel.completePercentage.value * 100).toString(),
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              barRadius: const Radius.circular(8),
              padding: EdgeInsets.zero,
            ),
          );
        },
      ),
    );
  }
}
