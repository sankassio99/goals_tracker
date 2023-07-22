import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class GoalCalendarWidget extends StatelessWidget {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  final RxList<DateTime> selectedDays = RxList<DateTime>();

  GoalCalendarWidget({super.key, List<DateTime>? days}) {
    selectedDays.addAll(days ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Calendar",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => selectedDays.length > 1
                    ? TableCalendar(
                        focusedDay: _focusedDay,
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (DateTime day) {
                          var actual = DateTime(day.year, day.month, day.day);
                          for (var date in selectedDays) {
                            if (actual ==
                                DateTime(date.year, date.month, date.day)) {
                              return true;
                            }
                          }
                          return false;
                        },
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        availableGestures: AvailableGestures.horizontalSwipe,
                        calendarStyle: const CalendarStyle(
                          defaultTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          weekendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          outsideTextStyle: TextStyle(fontSize: 0),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary),
                          weekendStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
