import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo_app/models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  @override
  void onInit() {
    List? stored = GetStorage().read<List>("todos");

    if (stored != null && stored.isNotEmpty) {
      for (var element in stored) {
        todos.add(Todo.fromJson(element));
      }
    }
    ever(todos, (_) => {GetStorage().write("todos", todos.toList())});
    super.onInit();
  }
}
