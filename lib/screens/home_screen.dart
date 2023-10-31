import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/todo_controller.dart';
import 'package:getx_todo_app/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo LIST"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Get.to(TodoScreen(
            index: -1,
          ))
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Obx(() => ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  var toBeRemoved = todoController.todos[index];
                  todoController.todos.removeAt(index);
                  Get.snackbar("Task Rimosso",
                      'il task ${toBeRemoved.text} è stato cancellato',
                      snackPosition: SnackPosition.BOTTOM,
                      mainButton: TextButton(
                          onPressed: () {
                            todoController.todos.insert(index, toBeRemoved);
                          },
                          child: const Text("Annulla")));
                },
                child: ListTile(
                  title: Text(
                    todoController.todos[index].text,
                    style: todoController.todos[index].done
                        ? const TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough)
                        : TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                  onTap: () => {Get.to(TodoScreen(index: index))},
                  leading: Checkbox(
                      value: todoController.todos[index].done,
                      onChanged: (value) {
                        var changed = todoController.todos[index];
                        changed.done = value ?? false;
                        todoController.todos[index] = changed;
                      }),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              itemCount: todoController.todos.length,
              separatorBuilder: (_, __) => const Divider(),
            )),
      ),
    );
  }
}
