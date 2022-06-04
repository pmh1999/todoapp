import 'package:todoapp/model/todo.dart';
import 'package:todoapp/database/database_helper.dart';

class TodosRepository {
  Future<List<Todo>> getAll() async {
    return await DatabaseHelper.instance.getAll();
  }

  Future<List<Todo>> getAllProcessing() async {
    return await DatabaseHelper.instance.getAllProcessing();
  }

  Future<List<Todo>> getAllCompleted() async {
    return await DatabaseHelper.instance.getAllCompleted();
  }

  Future<bool> updateTodo(Todo todo) async {
    return await DatabaseHelper.instance.updateTodo(todo);
  }

  Future<Todo> addTodo(Todo todo) async {
    await DatabaseHelper.instance.addTodo(todo);
    return todo;
  }

  Future<bool> deleteTodo(int id) async {
    return await DatabaseHelper.instance.deleteTodo(id);
  }
}
