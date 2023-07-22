import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/models/goal_meansure_type.dart';

class DropdownFormField extends StatelessWidget {
  final Rx<GoalMeansureType> goalTypeSelected;
  final List<GoalMeansureType> goalTypes;
  final Function(GoalMeansureType newType) onSelected;

  const DropdownFormField({
    super.key,
    required this.goalTypeSelected,
    required this.goalTypes,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
          child: Text(
            "Meansure Type",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Obx(
          () => Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: DropdownButton(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              underline: Container(),
              enableFeedback: false,
              style: const TextStyle(),
              focusColor: Colors.transparent,
              value: goalTypeSelected.value.name,
              items: goalTypes
                  .map<DropdownMenuItem<String>>((GoalMeansureType type) {
                return DropdownMenuItem(
                  value: type.name,
                  child: Text(
                    type.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? goalType) {
                var selected =
                    goalTypes.firstWhereOrNull((type) => type.name == goalType);

                goalTypeSelected.value = selected!;

                onSelected(selected);
              },
            ),
          ),
        ),
      ],
    );
  }
}
