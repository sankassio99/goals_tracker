import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class GoalCalendarWidget extends StatelessWidget {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();

  GoalCalendarWidget({super.key});

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
                  color: Colors.black12,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(
                      day, DateTime(kToday.year, kToday.month + 3, kToday.day));
                },
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                availableGestures: AvailableGestures.horizontalSwipe,
                calendarStyle: const CalendarStyle(
                  defaultTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  weekendTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  outsideTextStyle: TextStyle(fontSize: 0),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54),
                  weekendStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
