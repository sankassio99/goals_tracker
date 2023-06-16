import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class GoalCardWidget extends StatelessWidget {
  final GoalModel model;
  const GoalCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/mainGoalDetails/${model.id}"),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: Icon(
                  key: const Key("goalCardIcon"),
                  model.icon.value,
                  color: Colors.black87,
                  size: 34,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key: const Key("goalCardTitle"),
                      model.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Obx(
                      () => Text(
                        key: const Key("goalCardPercentage"),
                        getPercentageProgress(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPercentageProgress() {
    const suffix = "% complete";
    var percentage = model.completePercentage.value * 100;
    var percentageText = percentage.toStringAsFixed(0);
    return "$percentageText$suffix";
  }
}
