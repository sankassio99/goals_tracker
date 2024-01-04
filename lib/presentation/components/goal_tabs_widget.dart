import 'package:flutter/material.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/presentation/components/goalTabs/day_entries_widget.dart';
import 'package:goals_tracker/presentation/components/goalTabs/deposit_entries_widget.dart';
import 'package:goals_tracker/presentation/components/goalTabs/calendar_widget.dart';
import 'package:goals_tracker/presentation/components/goalTabs/goal_desc_widget.dart';
import 'package:goals_tracker/presentation/components/goalTabs/tasks_widget.dart';
import 'package:goals_tracker/presentation/models/goal_meansure_type.dart';
import 'package:goals_tracker/presentation/models/goal_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TabsModel {
  int length;
  List<Tab> tabs;
  List<Widget> widgets;

  TabsModel(this.length, this.tabs, this.widgets);
}

class GoalTabsBar extends StatelessWidget {
  final GoalModel model;
  late final TabsModel _tabsModel;

  // ignore: prefer_const_constructors_in_immutables
  GoalTabsBar({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    _tabsModel = genrateTabsModel(model.meansureType);

    return DefaultTabController(
      length: _tabsModel.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            dividerColor: Theme.of(context).colorScheme.outline,
            tabs: _tabsModel.tabs,
          ),
        ),
        body: TabBarView(
          children: _tabsModel.widgets,
        ),
      ),
    );
  }

  genrateTabsModel(GoalMeansureType meansureType) {
    List<Tab> tabs = [];
    int length = 0;
    List<Widget> widgets = [];

    if (meansureType.type == GoalType.monetary) {
      length = 3;
      tabs = [
        Tab(
            key: const Key("depositsIconTab"),
            icon: Icon(PhosphorIcons.bold.money)),
        Tab(
            key: const Key("calendarIconTab"),
            icon: Icon(PhosphorIcons.bold.calendar)),
        Tab(
            key: const Key("descIconTab"),
            icon: Icon(PhosphorIcons.bold.article)),
      ];
      widgets = [
        DepositEntriesWidget(
          key: const Key("myDepositsTab"),
        ),
        GoalCalendarWidget(
          key: const Key("myCalendarTab"),
          days: model.dayEntries.map((entry) => entry.value).toList(),
        ),
        GoalDescWidget(
          key: const Key("myDescTab"),
          model: model,
        ),
      ];
    }

    if (meansureType.type == GoalType.tasks) {
      length = 2;
      tabs = [
        Tab(
            key: const Key("tasksIconTab"),
            icon: Icon(PhosphorIcons.bold.check)),
        Tab(
            key: const Key("descIconTab"),
            icon: Icon(PhosphorIcons.bold.article)),
      ];
      widgets = [
        TasksWidget(key: const Key("myTasksTab"), tasks: model.tasks),
        GoalDescWidget(
          key: const Key("myDescTab"),
          model: model,
        ),
      ];
    }

    if (meansureType.type == GoalType.days) {
      length = 3;
      tabs = [
        Tab(
          key: const Key("daysIconTab"),
          icon: Icon(PhosphorIcons.bold.sun),
        ),
        Tab(
            key: const Key("calendarIconTab"),
            icon: Icon(PhosphorIcons.bold.calendar)),
        Tab(
            key: const Key("descIconTab"),
            icon: Icon(PhosphorIcons.bold.article)),
      ];
      widgets = [
        DayEntriesWidget(
          key: const Key("myDaysTab"),
        ),
        GoalCalendarWidget(
          key: const Key("myCalendarTab"),
          days: model.dayEntries.map((entry) => entry.value).toList(),
        ),
        GoalDescWidget(
          key: const Key("myDescTab"),
          model: model,
        ),
      ];
    }

    return TabsModel(length, tabs, widgets);
  }
}
