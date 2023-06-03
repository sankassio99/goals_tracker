import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goals_tracker/presentation/components/goal_list_widget.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../components/bottom_button.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({super.key});

  List<GoalModel> goalsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 24, 8.0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
                  child: Text(
                    "Your Goals",
                    key: const Key("homeTitle"),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black12,
                ),
                GoalListWidget(goals: goalsList),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          label: "Add goal",
          action: () => addNewGoal(),
        ),
      ],
    );
  }

  addNewGoal() {
    goalsList.add(GoalModel("id"));
  }
}
