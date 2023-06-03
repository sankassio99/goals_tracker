import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';

class GoalListWidget extends StatelessWidget {
  final List<GoalModel> goals;

  const GoalListWidget({
    required this.goals,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
            ),
          ),
          ListView(
            key: const Key("goalCardsListView"),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: goals.map((goal) => GoalCardWidget(model: goal)).toList(),
          ),
        ],
      ),
    );
  }
}
