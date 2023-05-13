import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/controllers/goal_list_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:provider/provider.dart';

class GoalListWidget extends StatelessWidget {
  final List<GoalModel> goals;

  GoalListWidget({required this.goals, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GoalListController>(context);
    print(goals.length);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
            ),
          ),
          ListView(
            key: const Key("goalCardsListView"),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: goals
                .map((goal) => GoalCardWidget(
                      model: goal,
                      onTap: () => controller.goalDetails(context, goal.id),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
