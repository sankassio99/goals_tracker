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
        constraints: BoxConstraints(
            minWidth: 100, maxWidth: MediaQuery.of(context).size.width),
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
          padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: PhosphorIcon(
                  key: const Key("goalCardIcon"),
                  model.icon.value,
                  color: Colors.black87,
                  size: 34,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      key: const Key("goalCardTitle"),
                      (model.name == "" ? "Tap to edit" : model.name),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 36, child: ProgressBar(goalModel: model)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
