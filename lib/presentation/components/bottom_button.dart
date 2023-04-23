import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/pages/main_goal_page_widget.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: const Key("addNewGoalButton"),
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(400, 60),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              key: Key("goalCardIcon"),
              Icons.add,
              color: Colors.black87,
              size: 24,
            ),
            Text(
              'Add goal',
            ),
          ],
        ),
      ),
    );
  }
}
