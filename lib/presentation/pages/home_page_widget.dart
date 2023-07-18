import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/presentation/components/formFields/dropdown_form_field.dart';
import 'package:goals_tracker/presentation/components/formFields/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:goals_tracker/presentation/controllers/home_controller.dart';
import 'package:goals_tracker/presentation/models/goal_meansure_type.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import '../components/bottom_button.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({super.key});
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    controller.loadGoals();
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
                  height: MediaQuery.of(context).size.height - 200,
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: controller.goalList
                              .map((goalModel) =>
                                  GoalCardWidget(model: goalModel))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        key: const Key("dialogAddGoal"),
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          enableDrag: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          context: context,
          builder: (BuildContext context) => AddGoalDialog(),
        ),
      ),
    );
  }
}

class AddGoalDialog extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final GoalModel goalModel = GoalModel("", "");

  AddGoalDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Container(
      padding: mediaQueryData.viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            key: const Key("addGoalDialog"),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Goal",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                FormFieldWidget(
                  key: const Key("goalName"),
                  label: "Name",
                  controller: goalModel.name,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownFormField(
                  goalTypeSelected: goalModel.meansureType.obs,
                  goalTypes: [
                    GoalMeansureType(GoalType.monetary),
                    GoalMeansureType(GoalType.tasks),
                    GoalMeansureType(GoalType.days),
                  ],
                  onSelected: goalModel.setMeansureType,
                ),
                const SizedBox(
                  height: 8,
                ),
                FormFieldWidget(
                  key: const Key("goalTarget"),
                  label: "Target",
                  controller: goalModel.target,
                  maxLines: 1,
                  typeNumber: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        key: const Key("addGoalButton"),
                        child: const Text("CREATE"),
                        onPressed: () {
                          controller.addGoal(goalModel);
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
