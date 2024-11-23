import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';

Future<void> initializeHive() async {
  try {
    await Hive.initFlutter();
    print("Hive initialized");
  } catch (e) {
    print('Error initializing Hive: $e');
  }
  Hive.registerAdapter(TaskAdapter());

  openTasksBox();
  openCompletedTasksBox();
}

Future<void> openTasksBox() async {
  await Hive.openBox<Task>('tasksBox');
}

Future<void> openCompletedTasksBox() async {
  await Hive.openBox<Task>('completedTasksBox');
}
