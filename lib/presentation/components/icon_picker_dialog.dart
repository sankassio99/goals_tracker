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
    Icons.ballot,
    Icons.games_rounded,
    Icons.motorcycle,
    Icons.food_bank,
  ];

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
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
