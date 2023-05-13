import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final Function action;
  final String label;

  BottomButton({
    super.key,
    required this.action,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        key: const Key("addNewGoalButton"),
        onPressed: () => action.call(),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(400, 60),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              key: Key("goalCardIcon"),
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
            Text(
              label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
