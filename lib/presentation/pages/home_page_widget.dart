import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Center(
            child: Container(
              width: 400,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    width: 400,
                    height: 100,
                    color: Colors.amber,
                  ),
                  Center(
                    child: ElevatedButton(
                      key: const Key("addNewGoalButton"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainGoalPageWidget()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(390, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      child: const Text('Add goal'),
                    ),
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
