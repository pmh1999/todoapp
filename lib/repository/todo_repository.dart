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
    await DatabaseHelper.instance.updateTodo(todo);
    return true;
  }

  Future<bool> addTodo(Todo todo) async {
    await DatabaseHelper.instance.addTodo(todo);
    return true;
  }

  Future<bool> deleteTodo(Todo todo) async {
    await DatabaseHelper.instance.deleteTodo(todo.id);
    return true;
  }
}
