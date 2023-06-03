import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import '../components/bottom_button.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({super.key});
  final controller = Get.find<HomeController>();

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
                SizedBox(
                  height: 400,
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.goalList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child:
                              GoalCardWidget(model: controller.goalList[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          label: "Add goal",
          action: () => controller.addNewGoal(),
        ),
      ],
    );
  }
}
