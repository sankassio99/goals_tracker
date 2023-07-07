import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IconPickerDialog extends StatelessWidget {
  final Rx<PhosphorIconData> currentIcon;
  final controller = Get.find<MainGoalController>();
  final double? size;

  IconPickerDialog({
    required this.currentIcon,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => PickerDialog(
                selectedIcon: currentIcon.value.obs,
              )),
      child: Obx(
        () => Icon(
          key: const Key("goalIcon"),
          currentIcon.value,
          color: Colors.black87,
          size: size ?? 24,
        ),
      ),
    );
  }
}

class PickerDialog extends StatelessWidget {
  final Rx<PhosphorIconData> selectedIcon;
  final controller = Get.find<MainGoalController>();

  PickerDialog({
    required this.selectedIcon,
    super.key,
  });

  final List<PhosphorIconData> iconsData = [
    PhosphorIcons.regular.target,
    PhosphorIcons.regular.airplaneTakeoff,
    PhosphorIcons.regular.alien,
    PhosphorIcons.regular.alignBottom,
    PhosphorIcons.regular.anchor,
    PhosphorIcons.regular.archive,
    PhosphorIcons.regular.backpack,
    PhosphorIcons.regular.basketball,
    PhosphorIcons.regular.baseballCap,
    PhosphorIcons.regular.batteryChargingVertical,
    PhosphorIcons.regular.beerBottle,
    PhosphorIcons.regular.bicycle,
    PhosphorIcons.regular.bird,
    PhosphorIcons.regular.boot,
    PhosphorIcons.regular.books,
    PhosphorIcons.regular.bookmarks,
    PhosphorIcons.regular.brandy,
    PhosphorIcons.regular.cake,
    PhosphorIcons.regular.barbell,
    PhosphorIcons.regular.appleLogo,
    PhosphorIcons.regular.armchair,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key("iconPickerDialog"),
      backgroundColor: Colors.white,
      content: Padding(
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
              ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              style: Theme.of(context).textTheme.bodyMedium,
              "Close",
            )),
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
