import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class GoalTypeTag extends StatelessWidget {
  const GoalTypeTag({
    super.key,
    required this.model,
  });

  final GoalModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Text(
        model.meansureType.name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
