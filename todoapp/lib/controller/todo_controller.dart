import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/repository/todo_repository.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  final todos = <Todo>[].obs;
  final filter = 0.obs;
  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  @override
  void onDispose() {}

  Future<void> fetchAll() async {
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

  Future<void> addTodo(String title, String task) async {
    Todo tmp = Todo(todos.length, title, task, false);
    await Get.find<TodosRepository>().addTodo(tmp);
  }

  Future<void> deleteTodo(int index) async {
    await Get.find<TodosRepository>().deleteTodo(todos[index].id!);
    fetchAll();
  }

  void filterTodos(int index) {
    filter.value = index;
    fetchAll();
  }
}
