import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/todo_controller.dart';
import 'package:getx_todo_app/models/todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();
  final int index;

  TodoScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    String saveLabel = "Salva";
    if (index >= 0) {
      textEditingController.text = todoController.todos[index].text;
      saveLabel = "Modifica";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("$saveLabel Todo"),
        ),
        body: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: "Cosa vuoi fare?",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.multiline,
                maxLength: 999,
                maxLines: 30,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: const Text("Annulla"),
                    onPressed: () => {Get.back()},
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (index > -1) {
                          var editedVar = todoController.todos[index];
                          editedVar.text = textEditingController.text;
                          todoController.todos[index] = editedVar;
                        } else {
                          todoController.todos
                              .add(Todo(text: textEditingController.text));
                        }

                        Get.back();
                      },
                      child: Text(
                        saveLabel,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
