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
            child: Container(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Goals",
                    key: const Key("homeTitle"),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  GoalListWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          action: () => controller.goToMainGoal(context),
        ),
      ],
    );
  }
}
