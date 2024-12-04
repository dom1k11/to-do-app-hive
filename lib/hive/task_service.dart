import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';
import 'package:to_do_app_hive/models/task_model.dart';

Future<void> addTask(String taskName, String taskDescription,
    DateTime taskDeadline, String taskPriority) async {
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

  taskNameController.clear();
  taskDescriptionController.clear();
  taskDeadlineController.clear();
  taskPriorityController.clear();
}

Future<void> deleteTask(int index) async {
  final tasksBox = Hive.box<Task>('tasksBox');
  await tasksBox.deleteAt(index);
  print("Task at index $index deleted");
}

Future<void> setCompleted(int index) async {
  final tasksBox = Hive.box<Task>('tasksBox');
  final completedTasksBox = Hive.box<Task>('completedTasksBox');
  final newTask = tasksBox.getAt(index);
  if(newTask != null){
    completedTasksBox.add(newTask);
    tasksBox.deleteAt(index);
  }
  print("task marked as completed, $index");


}

Future<void> editTask(int index) async {
  final tasksBox = Hive.box<Task>('tasksBox');

  // Получаем задачу по индексу
  final newTask = tasksBox.getAt(index);

  if (newTask != null) {
    // Обновляем поля задачи новыми значениями из контроллеров
    newTask.taskName = taskNameController.text;
    newTask.taskDescription = taskDescriptionController.text;
    newTask.taskDeadline = DateFormat("MM/dd/yyyy").parse(taskDeadlineController.text);
    newTask.taskPriority = taskPriorityController.text;

    // Сохраняем изменения в Hive
    await tasksBox.putAt(index, newTask);

    // Очищаем контроллеры после сохранения
    taskNameController.clear();
    taskDescriptionController.clear();
    taskDeadlineController.clear();
    taskPriorityController.clear();
  }
}

