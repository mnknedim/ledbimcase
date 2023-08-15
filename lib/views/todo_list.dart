import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledbim_case/controller/all_controller.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final AllController controller = Get.put(AllController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.tasks[index].title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.removeTask(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.taskEditingController,
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      controller.addTask();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter task',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.addTask();
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
