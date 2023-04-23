import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomeController extends ChangeNotifier {
  HomeController() {}

  goToMainGoal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainGoalPageWidget(
          isCreatedNow: true.obs,
        ),
      ),
    );
  }
}
