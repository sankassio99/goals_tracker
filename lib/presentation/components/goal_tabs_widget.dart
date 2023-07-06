import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/presentation/components/form_field_widget.dart';
import 'package:goals_tracker/presentation/components/goalTabs/tasks_widget.dart';
import 'package:goals_tracker/presentation/controllers/main_goal_controller.dart';
import 'package:goals_tracker/presentation/models/deposit_entry_model.dart';
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
  final controller = Get.find<MainGoalController>();

  DepositEntriesWidget({super.key});

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
                "My deposit entries",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                key: const Key("addDepositButton"),
                onPressed: () async {
                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        key: const Key("addDepositEntryDialog"),
                        child: Container(
                          width: 400,
                          height: 300,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "What is the value?",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              FormFieldWidget(
                                key: const Key("depositValueInput"),
                                label: "",
                                controller: textEditingController,
                                typeNumber: true,
                              ),
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
                                        controller.addDepositEntry(
                                            textEditingController.text);
                                      },
                                      child: const Text(
                                        key: Key("confirmAddDeposit"),
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
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.goalModel.value.depositEntries
                  .map(
                    (deposit) => DepositEntryWidget(
                        key: ValueKey(deposit), model: deposit),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DepositEntryWidget extends StatelessWidget {
  final DepositEntryModel model;
  const DepositEntryWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("depositEntry"),
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
      child: Text(model.value.toStringAsFixed(2)),
    );
  }
}
