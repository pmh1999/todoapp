 import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/database/databaseHelper.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  var todos = <Todo>[].obs;
  var allTodos = <Todo>[].obs;
  late TextEditingController addTaskController;
  var filter = 0.obs;
  @override
  void onInit() {
    addTaskController = TextEditingController();
    fetchAll();
    super.onInit();
  }

  Future<void> fetchAll() async {
    DatabaseHelper.instance.getAll().then((value) => {
          value.forEach((element) {
            allTodos.add(element);
            todos.add(element);
          })

    });
  }

  Future<void> updateTodo(int index, bool isCompleted) async {
    Todo upd = Todo(
        todos[index].id, todos[index].title, todos[index].task, isCompleted);
    DatabaseHelper.instance.update(upd).catchError((onError) {
      debugPrint('failed to update todo: ${onError.toString()}');
    }).whenComplete(() => todos[index] = upd);
    return;
  }

  Future<void> addTodo(String title, String task) async {
    Todo tmp = Todo(todos.length, title, task, false);
    DatabaseHelper.instance.insert(tmp).catchError((onError) {
      debugPrint('failed to insert todo: ${onError.toString()}');
    }).whenComplete(() => todos.add(tmp));

    addTaskController.clear();

    return;
  }

  Future<void> deleteTodo(int index) async {
    DatabaseHelper.instance.delete(todos[index].id).catchError((error) {
      debugPrint('failed to delete todo: ${error.toString()}');
    }).whenComplete(() {
      todos.removeAt(index);
    });
    return;
  }

  void filterTodos(int index) {
    debugPrint('navigationbar index: ${index.toString()}');
    debugPrint('navigationbar index: ${todos.toString()}');
    todos = allTodos;
    filter = index.obs;
    if (filter.value == 1) todos = todos.where((todo) => todo.done!).toList().obs;
    if (filter.value == 2) todos = todos.where((todo) => !todo.done!).toList().obs;

    debugPrint('navigationbar index: ${todos.toString()}');

  }
}
