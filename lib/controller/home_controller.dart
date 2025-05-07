import 'package:get/get.dart';
import 'package:todoapp/models/home_model.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[
    Task(title: 'Go to the gym', time: '10:30 AM'),
    Task(title: 'Study for the exam', time: '10:28 PM'),
    Task(title: 'Sleep', time: '3:05 AM', isCompleted: true),
    Task(title: 'Sleep', time: '3:05 AM', isCompleted: true),
    Task(title: 'Sleep', time: '3:05 AM', isCompleted: true),
    Task(title: 'Sleep', time: '3:05 AM', isCompleted: true),
    Task(title: 'Sleep', time: '3:05 AM', isCompleted: true),
    Task(title: 'Sleep', time: '3:05 AM', isCompleted: true),
  ].obs;

  void addTask(String title, String time) {
    tasks.add(Task(title: title, time: time, isCompleted: false));
  }

  void toggleComplete(int index) {
    final task = tasks[index];
    tasks[index] = Task(
      title: task.title,
      time: task.time,
      isCompleted: !task.isCompleted,
    );
  }
}
