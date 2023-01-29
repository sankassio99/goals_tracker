import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Column(
            children: [
              const Text(
                "Your Goals",
                key: Key("homeTitle"),
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1,
                indent: 50,
                endIndent: 50,
                color: Colors.black12,
              ),
              ElevatedButton(
                key: const Key("addNewGoalButton"),
                onPressed: () {
                  print('Button pressed ...');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                child: const Text('Add goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
