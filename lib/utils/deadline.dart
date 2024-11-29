import 'package:flutter/material.dart';
import 'package:to_do_app_hive/models/task_model.dart';

extension DeadlineExtension on Task {

  int get _daysLeft {
    final now = DateTime.now();
    final endOfTaskDate = DateTime(
      taskDeadline.year,
      taskDeadline.month,
      taskDeadline.day,
      23, 59, 59,
    );
    return endOfTaskDate.difference(now).inDays;
  }

  String get deadlineCounter {

    if (_daysLeft > 0) {
      return '$_daysLeft days left';
    } else if (_daysLeft == 0) {
      return 'Last Day';
    } else {
      return '${_daysLeft.abs()} days overdue';
    }
  }

  Color get deadlineCounterColor{

    if (_daysLeft > 2) {
    return Colors.green;
    }
    else if (_daysLeft == 2) {
      return Colors.yellow;
    }
    else {
      return Colors.red;
    }
  }

}
