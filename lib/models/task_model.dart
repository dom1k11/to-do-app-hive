import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  String taskDescription;

  @HiveField(2)
  DateTime taskDeadline;

  @HiveField(3)
  bool isTaskCompleted;

  @HiveField(4)
  String taskPriority;

  Task(
      {required this.taskName,
      this.taskDescription = "No Description",
      required this.taskDeadline,
      this.isTaskCompleted = false,
      required this.taskPriority});

}

