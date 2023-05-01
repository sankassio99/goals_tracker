import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: LinearPercentIndicator(
            percent: 0.7,
            width: MediaQuery.of(context).size.width * 0.87,
            lineHeight: 24,
            animation: true,
            progressColor: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: Theme.of(context).colorScheme.background,
            center: const Text(
              '70%',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            barRadius: const Radius.circular(8),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
