import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class GoalCardWidget extends StatelessWidget {
  final GoalModel model;
  const GoalCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
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
    );
  }
}
