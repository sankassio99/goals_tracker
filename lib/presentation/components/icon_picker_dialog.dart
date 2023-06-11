import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';

class IconPickerDialog extends StatelessWidget {
  final IconData? currentIcon;
  final Rx<IconData> selectedIcon = Icons.abc.obs;
  final controller = Get.find<MainGoalController>();

  IconPickerDialog({
    this.currentIcon,
    super.key,
  });

  final List<IconData> iconsData = const [
    Icons.access_alarm,
    Icons.account_tree_sharp,
    Icons.safety_check,
    Icons.laptop,
    Icons.girl,
    Icons.boy,
    Icons.car_rental,
    Icons.money,
    Icons.map,
    Icons.wind_power,
    Icons.monetization_on,
    Icons.gamepad,
    Icons.ballot,
    Icons.games_rounded,
    Icons.motorcycle,
    Icons.food_bank,
  ];

  @override
  Widget build(BuildContext context) {
    selectedIcon.value = currentIcon ?? Icons.food_bank;
    return Dialog(
      key: const Key("iconPickerDialog"),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Icon Picker Dialog",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  child: Obx(
                    () => GridView.count(
                      crossAxisCount: 4,
                      children: iconsData.map((iconData) {
                        if (selectedIcon.value == iconData) {
                          return SelectedIcon(iconData: iconData);
                        }
                        return InkWell(
                          onTap: () => selectedIcon.value = iconData,
                          child: Icon(
                            key: const Key("iconItemChoice"),
                            iconData,
                            color: Colors.black87,
                            size: 24,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          style: Theme.of(context).textTheme.bodyMedium,
                          "Close",
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          controller.updateIcon(selectedIcon);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          key: Key("confirmIconChoice"),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                          "Confirm",
                        )),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

class SelectedIcon extends StatelessWidget {
  final IconData iconData;
  const SelectedIcon({
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(5)),
      child: Icon(
        key: const Key("iconItemChoice"),
        iconData,
        color: Colors.black87,
        size: 24,
      ),
    );
  }
}
