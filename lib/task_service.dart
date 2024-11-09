import 'package:hive/hive.dart';
import 'package:to_do_app_hive/models/task_model.dart';

Future<void> addTask(String taskName, String taskDescription, DateTime taskDeadline, String taskPriority) async {
  // Открываем коробку
  final tasksBox = Hive.box<Task>('tasksBox');

  // Создаем новую задачу
  final newTask = Task(
    taskName: taskName,
    taskDescription: taskDescription,
    taskDeadline: taskDeadline,
    taskPriority: taskPriority,
  );

  // Добавляем задачу в коробку
  await tasksBox.add(newTask);
  print("New Task added");
  print(tasksBox.values.toList());
}

Future<void> deleteTask(int index) async {
  final tasksBox = Hive.box<Task>('tasksBox');
  await tasksBox.deleteAt(index);
  print("Task at index $index deleted");
}
