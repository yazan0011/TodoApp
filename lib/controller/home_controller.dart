import 'package:get/get.dart';
import 'package:todoapp/models/home_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(Task task) {
    tasks.add(task);
  }

  void toggleTask(int index) {
    var task = tasks[index];
    tasks[index] = Task(
      title: task.title,
      time: task.time,
      isCompleted: !task.isCompleted,
    );
    tasks.refresh();
  }

  List<Task> get incompleteTasks =>
      tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks =>
      tasks.where((task) => task.isCompleted).toList();
}
