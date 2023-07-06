import 'package:flutter/material.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/presentation/components/goalTabs/calendar_widget.dart';
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

  GoalTabsBar({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    _tabsModel = genrateTabsModel(model.meansureType);

    return DefaultTabController(
      length: _tabsModel.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
      length = 1;
      tabs = [
        Tab(
            key: const Key("depositsIconTab"),
            icon: Icon(PhosphorIcons.bold.money)),
      ];
      widgets = [
        DepositEntriesWidget(
          key: const Key("myDepositsTab"),
        )
      ];
    }

    if (meansureType.type == GoalType.tasks) {
      length = 1;
      tabs = [
        Tab(
            key: const Key("tasksIconTab"),
            icon: Icon(PhosphorIcons.bold.check)),
      ];
      widgets = [
        TasksWidget(key: const Key("myTasksTab"), tasks: model.tasks),
      ];
    }

    // List<Tab> tabs = [
    //   Tab(key: const Key("tasksIconTab"), icon: Icon(PhosphorIcons.bold.check)),
    //   Tab(
    //       key: const Key("calendarIconTab"),
    //       icon: Icon(PhosphorIcons.bold.calendar)),
    //   Tab(
    //       key: const Key("depositsIconTab"),
    //       icon: Icon(PhosphorIcons.bold.money)),
    // ];

    // List<Widget> widgets = [
    //   TasksWidget(key: const Key("myTasksTab"), tasks: model.tasks),
    //   GoalCalendarWidget(key: const Key("myCalendarTab")),
    //   DepositEntriesWidget(
    //     key: const Key("myDepositsTab"),
    //   )
    // ];

    return TabsModel(length, tabs, widgets);
  }
}

class DepositEntriesWidget extends StatelessWidget {
  const DepositEntriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                "My deposit entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                key: const Key("addDepositButton"),
                onPressed: () {},
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
        ],
      ),
    );
  }
}
