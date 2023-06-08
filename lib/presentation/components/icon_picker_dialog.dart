import 'package:flutter/material.dart';

class IconPickerDialog extends StatelessWidget {
  const IconPickerDialog({
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
    Icons.account_tree_sharp,
    Icons.gamepad,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key("iconPickerDialog"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Icon Picker Dialog"),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: iconsData
                        .map(
                          (iconData) => Icon(
                            key: const Key("iconItemChoice"),
                            iconData,
                            color: Colors.black87,
                            size: 24,
                          ),
                        )
                        .toList(),
                  ),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"))
              ]),
        ),
      ),
    );
  }
}
