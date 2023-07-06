import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/calendar_widget.dart';
import 'package:goals_tracker/presentation/components/tasks_widget.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalTabsBar extends StatelessWidget {
  final GoalModel model;
  const GoalTabsBar({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            dividerColor: Theme.of(context).colorScheme.outline,
            tabs: [
              Tab(
                  key: const Key("tasksIconTab"),
                  icon: Icon(PhosphorIcons.bold.check)),
              Tab(
                  key: const Key("calendarIconTab"),
                  icon: Icon(PhosphorIcons.bold.calendar)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TasksWidget(key: const Key("myTasksTab"), tasks: model.tasks),
            GoalCalendarWidget(key: const Key("myCalendarTab")),
          ],
        ),
      ),
    );
  }
}
