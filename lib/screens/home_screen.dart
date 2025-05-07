import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:todoapp/controller/home_controller.dart';
import 'package:todoapp/models/home_model.dart';

class TodoPage extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(children: [
        Positioned(
            child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 500),
          decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        )),
        Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'My Todo List',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'WinkySans',
                  color: Colors.white),
            ),
            const Text(
              'Aug 7, 2023',
              style: TextStyle(
                  fontSize: 16, color: Colors.white70, fontFamily: 'WinkySans'),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Obx(() {
                final incompleteTasks =
                    controller.tasks.where((t) => !t.isCompleted).toList();
                final completedTasks =
                    controller.tasks.where((t) => t.isCompleted).toList();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Incomplete Tasks
                      _buildTaskSection('Incomplete', incompleteTasks, false),
                      const SizedBox(height: 20),
                      // Completed Tasks
                      _buildTaskSection('Completed', completedTasks, true),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        Positioned(
            right: 20,
            top: 25,
            child: IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                controller.addTask('New Task', TimeOfDay.now().format(context));
              },
            )),
      ]),
    );
  }

  Widget _buildTaskSection(String title, List<Task> tasks, bool completed) {
    if (completed && tasks.isEmpty) {
      return const SizedBox(); // Return early if nothing to show
    }

    return AnimationLimiter(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 236, 236),
              border: Border.all(color: Colors.teal.shade400, width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 181, 181, 181),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                  spreadRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (completed)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey(
                        tasks.length), // Triggers rebuild when list changes
                    children: List.generate(tasks.length, (index) {
                      final task = tasks[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                final realIndex =
                                    controller.tasks.indexOf(task);
                                controller.toggleComplete(realIndex);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: completed
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      completed
                                          ? Icons.done
                                          : Icons.error_outline,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            task.time,
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      task.isCompleted
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: Colors.teal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}
