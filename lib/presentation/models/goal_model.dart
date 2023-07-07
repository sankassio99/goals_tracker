import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals_tracker/domain/entities/deposit_entry.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/main_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:goals_tracker/presentation/models/deposit_entry_model.dart';
import 'package:goals_tracker/presentation/models/goal_meansure_type.dart';
import 'package:goals_tracker/presentation/models/task_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalModel {
  String id;
  final TextEditingController name = TextEditingController(text: "");
  final TextEditingController description = TextEditingController(text: "");
  final TextEditingController target = TextEditingController(text: "");

  RxList<TaskModel> tasks = RxList<TaskModel>();
  RxDouble completeProgress = 0.0.obs;
  Rx<PhosphorIconData> icon =
      Rx<PhosphorIconData>(PhosphorIcons.fill.notePencil);

  DateTime? finalDate;
  GoalMeansureType meansureType = GoalMeansureType(GoalType.tasks);

  RxList<DepositEntryModel> depositEntries = RxList<DepositEntryModel>();

  GoalModel(
    this.id,
    String target, {
    GoalType goalType = GoalType.tasks,
    String description = "",
    String name = "",
    List<TaskModel>? taskList,
    List<DepositEntryModel>? deposits,
    double? progress,
    PhosphorIconData? iconData,
    this.finalDate,
  }) {
    meansureType = GoalMeansureType(goalType);
    this.description.text = description;
    tasks.value = taskList ?? [];
    depositEntries.value = deposits ?? [];
    completeProgress.value = progress ?? 0;
    icon.value = iconData ?? PhosphorIcons.fill.notePencil;
    this.name.text = name;
    this.target.text = target;
  }

  setFinalDate(DateTime? date) => finalDate = date;

  setMeansureType(GoalMeansureType newType) => meansureType = newType;

  void addTask() {
    tasks.add(TaskModel(""));
  }

  static toModel(MainGoal goal) {
    List<TaskModel> tasks = _mapToTaskModelList(goal.tasks);
    print(goal.depositEntries);
    List<DepositEntryModel> depositEntriesModel = goal.depositEntries != null
        ? _mapToDepositEntriesModelList(goal.depositEntries!)
        : [];

    return GoalModel(
      goal.id,
      goal.target,
      description: goal.desc,
      name: goal.title,
      taskList: tasks,
      progress: goal.completePercentage,
      iconData: goal.icon,
      finalDate: goal.finalDate,
      goalType: goal.type,
      deposits: depositEntriesModel,
    );
  }

  static List<DepositEntryModel> _mapToDepositEntriesModelList(
      List<DepositEntry> deposits) {
    List<DepositEntryModel> newDeposits = [];
    for (var deposit in deposits) {
      newDeposits.add(DepositEntryModel(deposit.value));
    }
    return newDeposits;
  }

  static List<TaskModel> _mapToTaskModelList(List<Task> tasks) {
    List<TaskModel> newTasks = [];
    for (var task in tasks) {
      newTasks.add(TaskModel.toModel(task));
    }
    return newTasks;
  }

  // TODO: Remove this mappers from here, please
  Goal toMainGoalEntity() {
    var tasks = _mapToTaskListEntity();
    var newDepositEntries = _mapToDepositEntriesListEntity();

    return MainGoal(
      id,
      name.text,
      description.text,
      target.text,
      taskList: tasks,
      completePercentage: completeProgress.value,
      icon: icon.value,
      finalDate: finalDate,
      type: meansureType.type,
      depositEntries: newDepositEntries,
    );
  }

  List<DepositEntry> _mapToDepositEntriesListEntity() {
    List<DepositEntry> newDeposits = [];
    for (var deposit in depositEntries) {
      newDeposits.add(deposit.toEntity());
    }
    return newDeposits;
  }

  List<Task> _mapToTaskListEntity() {
    List<Task> newTasks = [];
    for (var task in tasks) {
      newTasks.add(task.toTaskEntity());
    }
    return newTasks;
  }

  void updateProgress() {
    // TODO: Refactor to Strategy pattern
    if (meansureType.type == GoalType.tasks) {
      var checkedTasks = _countCheckedTasks();
      var progress = (checkedTasks / tasks.length).toStringAsFixed(2);
      completeProgress.value = double.parse(progress);
    }

    if (meansureType.type == GoalType.monetary) {
      var totalEntries = _getTotalEntries();
      var targetValue = double.parse(target.text);
      if (totalEntries > targetValue) {
        completeProgress.value = 1;
      } else {
        var progress = (totalEntries / targetValue).toStringAsFixed(2);
        completeProgress.value = double.parse(progress);
      }
    }
  }

  double _getTotalEntries() {
    var total = 0.0;
    for (var entry in depositEntries) {
      total += entry.value;
    }
    return total;
  }

  int _countCheckedTasks() {
    var checkedTasks = 0;
    for (var task in tasks) {
      if (task.checked.isTrue) checkedTasks++;
    }
    return checkedTasks;
  }

  void changeIcon(Rx<PhosphorIconData> icon) {
    this.icon.value = icon.value;
  }

  void addDepositEntry(DepositEntryModel depositEntry) {
    depositEntries.add(depositEntry);
  }
}
