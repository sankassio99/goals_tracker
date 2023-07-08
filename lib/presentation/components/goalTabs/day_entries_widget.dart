import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/formFields/date_form_field.dart';
import 'package:goals_tracker/presentation/components/formFields/form_field_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';

class DayEntriesWidget extends StatelessWidget {
  final controller = Get.find<MainGoalController>();

  DayEntriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var textEditingController = TextEditingController(text: "");

    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My day entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                key: const Key("addDayButton"),
                onPressed: () async {
                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        key: const Key("addDayEntryDialog"),
                        child: Container(
                          width: 400,
                          height: 221,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "What's the date?",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              DateFormField(
                                  selectedDate: DateTime.now().obs,
                                  onSelectDate: (date) {
                                    print(date);
                                  }),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        "Close",
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        controller.addDayEntry(
                                            textEditingController.text);
                                      },
                                      child: const Text(
                                        key: Key("confirmAddDay"),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                        "Confirm",
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Obx(
          //   () => Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: controller.goalModel.value.dayEntries
          //         .map(
          //           (day) => DayEntryWidget(key: ValueKey(day), model: day),
          //         )
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class DayEntryWidget extends StatelessWidget {
  final DayEntryModel model;
  const DayEntryWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("dayEntry"),
      height: 48,
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      width: double.infinity,
      alignment: AlignmentDirectional.centerStart,
      child: Text("model.value.toStringAsFixed(2)"),
    );
  }
}

class DayEntryModel {}
