import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class SubGoalCardWidget extends StatelessWidget {
  final GoalModel model;
  const SubGoalCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed("subGoalDetails", extra: model),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: Icon(
                  key: Key("goalCardIcon"),
                  Icons.playlist_add_check_rounded,
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
                    Text(
                      key: const Key("goalCardPercentage"),
                      '55% complete',
                      style: Theme.of(context).textTheme.bodySmall,
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
}
