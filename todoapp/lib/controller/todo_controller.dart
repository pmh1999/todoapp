import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/repository/todo_repository.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  final todos = <Todo>[].obs;
  final allTodos = <Todo>[].obs;
  final filter = 0.obs;
  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  @override
  void onDispose() {}

  Future<void> fetchAll() async {
    allTodos.value = await Get.find<TodosRepository>().getAll();
    if (filter.value == 0)
      todos.value = await Get.find<TodosRepository>().getAll();
    else if (filter.value == 1)
      todos.value = await Get.find<TodosRepository>().getAllCompleted();
    else
      todos.value = await Get.find<TodosRepository>().getAllProcessing();
    return;
  }

  Future<void> updateTodo(int index, bool isCompleted) async {
    Todo upd = Todo(
        todos[index].id, todos[index].title, todos[index].task, !isCompleted);
    await Get.find<TodosRepository>().updateTodo(upd);
    fetchAll();
  }

  Future<void> addTodo(Todo todo) async {
    await Get.find<TodosRepository>().addTodo(todo);
    todos.insert(0, todo);
    return;
  }

  Future<void> deleteTodo(Todo todo) async {
    await Get.find<TodosRepository>().deleteTodo(todo);
    todos.remove(todo);
  }

  void filterTodos(int index) {
    filter.value = index;
    fetchAll();
  }
}
