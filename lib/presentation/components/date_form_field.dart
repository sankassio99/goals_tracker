import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateFormField extends StatelessWidget {
  final Rx<DateTime?> selectedDate;
  final Function(DateTime? date) onSelectDate;

  const DateFormField({
    super.key,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
          child: Text(
            "Final Countdown",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            selectedDate.value = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025));
            onSelectDate(selectedDate.value);
          },
          child: Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Obx(
              () => Text(dateToString(selectedDate.value)),
            ),
          ),
        ),
      ],
    );
  }

  dateToString(DateTime? value) {
    if (value != null) {
      return "${value.day}/${value.month}/${value.year}";
    }

    return "";
  }
}