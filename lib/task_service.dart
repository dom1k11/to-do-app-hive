import 'package:hive/hive.dart';
import 'package:to_do_app_hive/models/task_model.dart';

Future<void> addTask(String taskName, String taskDescription, DateTime taskDeadline, String taskPriority) async {
  // Открываем коробку
  final box = Hive.box<Task>('tasksBox');

  // Создаем новую задачу
  final newTask = Task(
    taskName: taskName,
    taskDescription: taskDescription,
    taskDeadline: taskDeadline,
    taskPriority: 'empty priority',
  );

  // Добавляем задачу в коробку
  await box.add(newTask);
  print("New Task added");
  print(box.values.toList());

}
