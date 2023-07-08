import 'package:goals_tracker/domain/entities/deposit_entry.dart';
import 'package:goals_tracker/domain/entities/goal.dart';
import 'package:goals_tracker/domain/entities/goal_types_enum.dart';
import 'package:goals_tracker/domain/entities/sub_goal.dart';
import 'package:goals_tracker/domain/entities/task.dart';
import 'package:goals_tracker/presentation/models/day_entry_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainGoal extends Goal {
  List<SubGoal> subGoals = [];
  List<Task> tasks = [];
  List<DepositEntry> depositEntries = [];
  List<DayEntryModel> dayEntries = [];

  PhosphorIconData? icon;
  DateTime? finalDate;
  String target;

  MainGoal(
    super.id,
    super.title,
    super.desc,
    this.target, {
    super.completePercentage,
    super.isCompleted,
    super.type,
    this.icon,
    List<Task>? taskList,
    List<DepositEntry>? deposits,
    List<DayEntryModel>? days,
    this.finalDate,
  }) {
    tasks = taskList ?? [];
    depositEntries = deposits ?? [];
    dayEntries = days ?? [];
  }

  @override
  double getCompletePercentage() {
    _calculatePercent();
    return completePercentage;
  }

  void _calculatePercent() {
    var subGoalsCompletePercent = 0.0;
    var subGoalsTotalPercent = 0.0;

    if (subGoals.isNotEmpty) {
      subGoalsTotalPercent = subGoals.length * 100;

      for (var subGoal in subGoals) {
        subGoalsCompletePercent += subGoal.completePercentage;
      }

      completePercentage =
          ((subGoalsCompletePercent / subGoalsTotalPercent) * 100);
    }
  }

  void addSubGoal(SubGoal subGoal) {
    subGoals.add(subGoal);
  }

  List<SubGoal> getSubGoals() {
    return subGoals;
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  List<Task> getTasks() {
    return tasks;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'target': target,
      'completePercentage': completePercentage,
      'isCompleted': isCompleted,
      'type': type.toString(),
      'icon': icon?.codePoint.toString(),
      'iconStyle': icon?.fontFamily.toString(),
      'finalDate': finalDate?.toIso8601String(),
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'depositEntries': depositEntries?.map((entry) => entry.toJson()).toList(),
    };
  }

  MainGoal.fromJson(Map<String, dynamic> json)
      : target = json['target'],
        icon = getIconFromJson(json['icon'], json['iconStyle']),
        finalDate = json['finalDate'] != null
            ? DateTime.parse(json['finalDate'])
            : null,
        super(
          json['id'],
          json['title'],
          json['desc'],
          completePercentage: json['completePercentage'],
          isCompleted: json['isCompleted'],
          type: getGoalType(json['type']),
        ) {
    if (json['tasks'] != null) {
      tasks = [];
      for (var taskJson in json['tasks']) {
        tasks.add(Task.fromJson(taskJson));
      }
    }
    if (json['depositEntries'] != null) {
      depositEntries = [];
      for (var entryJson in json['depositEntries']) {
        depositEntries.add(DepositEntry.fromJson(entryJson));
      }
    }
  }

  static PhosphorIconData? getIconFromJson(String? json, String? style) {
    if (json != null && style != null) {
      var fontStyle = style.replaceAll("Phosphor", "");
      var iconData = PhosphorIconData(
        int.parse(json),
        fontStyle,
      );
      return iconData;
    }
    return null;
  }

  static GoalType getGoalType(String value) {
    return GoalType.values.firstWhere((type) => type.toString() == value);
  }
}
