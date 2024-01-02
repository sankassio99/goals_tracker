import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class GoalDescWidget extends StatelessWidget {
  const GoalDescWidget({
    super.key,
    required this.model,
  });
  final GoalModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
          key: const Key("descInput"),
          readOnly: true,
          controller: model.description,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Your goal description...',
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          )),
    );
  }
}
