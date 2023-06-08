import 'package:flutter/material.dart';

class IconPickerDialog extends StatelessWidget {
  const IconPickerDialog({
    super.key,
  });

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
                    children: const [
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                      Icon(
                        key: Key("iconItemChoice"),
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ],
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
