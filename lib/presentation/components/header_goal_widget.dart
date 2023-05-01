import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HeaderGoalWidget extends StatelessWidget {
  final RxBool editMode;
  final void Function(bool) titleFocusNode;
  final void Function(bool) descFocusNode;
  final TextEditingController titleTextController;
  final TextEditingController descTextController;

  const HeaderGoalWidget({
    super.key,
    required this.titleFocusNode,
    required this.editMode,
    required this.titleTextController,
    required this.descTextController,
    required this.descFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
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
                        titleFocusNode.call(value);
                      },
                      child: SizedBox(
                        width: 300,
                        height: 40,
                        child: Obx(
                          () => TextField(
                              key: const Key("titleInput"),
                              autofocus: editMode.value,
                              controller: titleTextController,
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
                Focus(
                  onFocusChange: (value) {
                    descFocusNode.call(value);
                  },
                  child: TextField(
                      key: const Key("descInput"),
                      controller: descTextController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Tap to type goal description...',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ],
            ),
          ),
        ),
        const ProgressBar(),
      ],
    );
  }
}
