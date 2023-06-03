import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/controllers/sub_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:provider/provider.dart';

class SubGoalPageWidget extends StatelessWidget {
  final _unfocusNode = FocusNode();
  final GoalModel goalModel;

  SubGoalPageWidget({super.key, required this.goalModel});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SubGoalController>(context);
    controller.setCurrentGoal(goalModel);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const MyAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
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
                      height: 199,
                      decoration: const BoxDecoration(
                        color: Colors.white,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
