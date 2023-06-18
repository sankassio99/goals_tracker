import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/progress_bar.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalCardWidget extends StatelessWidget {
  final GoalModel model;
  const GoalCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/mainGoalDetails/${model.id}"),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 800),
        height: 90,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.background,
              width: 2.0,
            ),
          ),
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
                child: PhosphorIcon(
                  key: const Key("goalCardIcon"),
                  model.icon.value,
                  color: Colors.black87,
                  size: 34,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: LayoutBuilder(builder: (context, constrained) {
                  return Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 400),
                    width: context.width * 0.7,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key: const Key("goalCardTitle"),
                          model.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ProgressBar(goalModel: model),
                      ],
                    ),
                  );
                }),
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
