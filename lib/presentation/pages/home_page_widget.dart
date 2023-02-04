import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/goal_list_widget.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        Center(
          child: ElevatedButton(
            key: const Key("addNewGoalButton"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainGoalPageWidget(
                          isCreatedNow: true.obs,
                        )),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(400, 60),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  key: Key("goalCardIcon"),
                  Icons.add,
                  color: Colors.black87,
                  size: 24,
                ),
                Text(
                  'Add goal',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
