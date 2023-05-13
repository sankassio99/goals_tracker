import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/goal_list_widget.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:provider/provider.dart';
import '../components/bottom_button.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

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
                GoalListWidget(
                  goals: controller.goalList,
                  onGoalTap: controller.goToMainGoal,
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          label: "Add goal",
          action: () => controller.addNewGoal(context),
        ),
      ],
    );
  }
}
