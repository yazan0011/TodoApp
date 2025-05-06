import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controller/home_controller.dart';
import 'package:todoapp/models/home_model.dart';

void main() {
  runApp(GetMaterialApp(home: TodoApp()));
}

class TodoApp extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());

  TodoApp({super.key}) {
    // Example tasks
    controller.addTask(
        Task(title: "Go to the gym", time: DateTime(2023, 8, 7, 10, 30)));
    controller.addTask(
        Task(title: "Study for the exam", time: DateTime(2023, 8, 7, 22, 28)));
    controller.addTask(Task(
        title: "sleep", time: DateTime(2023, 8, 7, 3, 5), isCompleted: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        elevation: 0,
        title: const Text('My Todo List', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final incomplete = controller.incompleteTasks;
                // final complete = controller.completedTasks;
                return AnimatedList(
                  key: GlobalKey<AnimatedListState>(),
                  initialItemCount: incomplete.length,
                  itemBuilder: (context, index, animation) {
                    return _buildTaskTile(
                        incomplete[index], index, animation, false);
                  },
                );
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Completed",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Obx(() {
                final complete = controller.completedTasks;
                return AnimatedList(
                  key: GlobalKey<AnimatedListState>(),
                  initialItemCount: complete.length,
                  itemBuilder: (context, index, animation) {
                    return _buildTaskTile(
                        complete[index], index, animation, true);
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.addTask(Task(
                    title: "New Task",
                    time: DateTime.now(),
                  ));
                },
                child: const Text("Add New Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTile(
      Task task, int index, Animation<double> animation, bool completed) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: completed ? Colors.deepPurple.shade100 : Colors.purple.shade100,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Icon(
            completed ? Icons.check_circle : Icons.favorite,
            color: completed ? Colors.deepPurple : Colors.orange,
          ),
          title: Text(task.title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(DateFormat.jm().format(task.time)),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => controller.toggleTask(
              controller.tasks.indexOf(task),
            ),
          ),
        ),
      ),
    );
  }
}
