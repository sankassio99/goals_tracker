import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/presentation/components/goal_settings_dialog.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';
import 'package:goals_tracker/presentation/components/my_app_bar.dart';
import 'package:goals_tracker/presentation/components/tasks_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class MainGoalPageWidget extends StatelessWidget {
  final controller = Get.find<MainGoalController>();

  MainGoalPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getGoal();
    return GetBuilder<MainGoalController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: MyAppBar(
          leading: IconButton(
            key: const Key("backIconButton"),
            icon: Icon(
              PhosphorIcons.bold.arrowLeft,
              color: Colors.black87,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed("/home");
            },
          ),
          actions: [
            IconButton(
              key: const Key("goalSettings"),
              icon: Icon(
                PhosphorIcons.bold.gear,
                color: Colors.black87,
              ),
              tooltip: 'Edit',
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    GoalSettingsDialog(goalModel: controller.goalModel.value),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: 1000,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderGoalWidget(
                    model: controller.goalModel.value,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                        width: context.width,
                        height: context.height,
                        child: GoalTabBar(model: controller.goalModel.value));
                  }),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key("addTaskButton"),
          child: const Icon(Icons.add),
          onPressed: () => controller.addTask(),
        ),
      );
    });
  }
}

class GoalTabBar extends StatelessWidget {
  final GoalModel model;
  const GoalTabBar({super.key, required this.model});

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
              Tab(icon: Icon(PhosphorIcons.bold.check)),
              Tab(icon: Icon(PhosphorIcons.bold.calendar)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TasksWidget(tasks: model.tasks),
            GoalCalendarWidget(),
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0),
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
          Container(
            height: 400,
            width: 500,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
