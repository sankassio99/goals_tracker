import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../components/bottom_button.dart';

class MainGoalPageWidget extends StatelessWidget {
  final GoalModel model;

  const MainGoalPageWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const MyAppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 213,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: HeaderGoalWidget(
                      model: model,
                    ),
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black12,
                ),
                // Consumer<MainGoalController>(
                //     builder: (context, controller, child) {
                //   return ListView(
                //     key: const Key("goalCardsListView"),
                //     padding: EdgeInsets.zero,
                //     shrinkWrap: true,
                //     scrollDirection: Axis.vertical,
                //     children: controller.currentGoal.subGoals
                //         .map((goal) => SubGoalCardWidget(model: goal))
                //         .toList(),
                //   );
                // }),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          label: "Add sub goal",
          action: () {},
        )
      ],
    );
  }
}
