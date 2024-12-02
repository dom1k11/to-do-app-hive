import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app_hive/screens/edit_task_screen.dart';
import 'package:to_do_app_hive/screens/tasks_screen/tasks_screen.dart';
import 'package:to_do_app_hive/screens/done_tasks_screen.dart';
import 'package:to_do_app_hive/screens/new_task_screen/new_task_screen.dart';
import 'package:to_do_app_hive/models/task_model.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String editScreen = '/edit_screen';
  static const String tasksScreen = '/tasks_screen';
  static const String doneTasksScreen = '/done_tasks_screen';
  static const String newTaskScreen = '/new_task_screen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case tasksScreen:
        return PageTransition(
          child: const TasksScreen(),
          type: PageTransitionType.rightToLeftWithFade,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          opaque: true,
        );

      case doneTasksScreen:
        return PageTransition(
          child: const DoneTasksScreen(),
          type: PageTransitionType.leftToRightWithFade,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          opaque: true,
        );
      case newTaskScreen:
        return PageTransition(
          child: const NewTaskScreen(),
          type: PageTransitionType.rightToLeftWithFade,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          opaque: true,
        );
      case editScreen:
        final task = settings.arguments as Task?;
        return PageTransition(
          child: EditTaskScreen(task: task!),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          curve: Curves.elasticOut,
          duration: const Duration(milliseconds: 2000),
          reverseDuration: const Duration(milliseconds: 500),
        );
      default:
        return null;
    }
  }
}
