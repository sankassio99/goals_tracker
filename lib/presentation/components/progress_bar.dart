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
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Obx(
            () => LinearPercentIndicator(
              key: const Key("progressBar"),
              percent: goalModel.completePercentage.value,
              width: MediaQuery.of(context).size.width * 0.87,
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
          ),
        ),
      ),
    );
  }
}
