import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/goal_list_widget.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:provider/provider.dart';
import '../components/bottom_button.dart';

class MainGoalPageWidget extends StatelessWidget {
  final _unfocusNode = FocusNode();
  RxBool? isCreatedNow = false.obs;
  GoalModel goalModel;

  MainGoalPageWidget({this.isCreatedNow, required this.goalModel});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainGoalController>(context);
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
                      child: HeaderGoalWidget(
                        editMode: isCreatedNow!,
                        titleFocusNode: (value) =>
                            controller.onInputFocusChange(value),
                        titleTextController: goalModel.nameController,
                        descFocusNode: (value) =>
                            controller.onInputFocusChange(value),
                        descTextController: goalModel.descriptionController,
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
                  GoalListWidget(goals: controller.currentGoal.subGoals)
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BottomButton(
          label: "Add sub goal",
          action: () => controller.addSubGoal(),
        )
      ],
    );
  }
}
