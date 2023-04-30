import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HeaderGoalWidget extends StatelessWidget {
  final RxBool editMode;
  final void Function(bool) onInputFocusChange;
  final TextEditingController textController;

  const HeaderGoalWidget({
    super.key,
    required this.onInputFocusChange,
    required this.editMode,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
                      child: Icon(
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                    Focus(
                      onFocusChange: (value) {
                        onInputFocusChange.call(value);
                      },
                      child: Container(
                        width: 300,
                        height: 40,
                        child: Obx(
                          () => TextField(
                              key: const Key("titleInput"),
                              autofocus: editMode.value,
                              controller: textController,
                              decoration: const InputDecoration(
                                  hintText: 'Goal name',
                                  border: InputBorder.none),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                  'Tap to type goal description',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: LinearPercentIndicator(
                percent: 0.5,
                width: MediaQuery.of(context).size.width * 0.87,
                lineHeight: 24,
                animation: true,
                progressColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Color(0xFFF1F4F8),
                center: const Text(
                  '50%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
                barRadius: Radius.circular(5),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
