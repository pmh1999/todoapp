import 'dart:async' as _async;

import 'package:todoapp/model/todo.dart';
import 'package:todoapp/repository/todo_repository.dart';
import 'package:mockito/mockito.dart';

class _FakeTodo_0 extends Fake implements Todo {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends Mock implements TodosRepository {
  MockUserRepository() {
    throwOnMissingStub(this);
  }

  @override
  _async.Future<List<Todo>> getAllProcessing() =>
      (super.noSuchMethod(Invocation.method(#getAllProcessing, []),
              returnValue: Future<List<Todo>>.value(<Todo>[]))
          as _async.Future<List<Todo>>);
  @override
  _async.Future<List<Todo>> getAllCompleted() =>
      (super.noSuchMethod(Invocation.method(#getAllCompleted, []),
              returnValue: Future<List<Todo>>.value(<Todo>[]))
          as _async.Future<List<Todo>>);
  @override
  _async.Future<Todo> addTodo(Todo todo) => (super.noSuchMethod(
      Invocation.method(#addTodo, [todo]),
      returnValue: Future<Todo>.value(_FakeTodo_0())) as _async.Future<Todo>);
  @override
  _async.Future<List<Todo>> getAll() =>
      (super.noSuchMethod(Invocation.method(#getAll, []),
              returnValue: Future<List<Todo>>.value(<Todo>[]))
          as _async.Future<List<Todo>>);
  @override
  _async.Future<bool> deleteTodo(int index) =>
      (super.noSuchMethod(Invocation.method(#deleteTodo, [index]),
          returnValue: Future<bool>.value(true)) as _async.Future<bool>);
}

/// A class which mocks [Todo].
class MockTodo extends Mock implements Todo {
  MockTodo() {
    throwOnMissingStub(this);
  }

  @override
  String get title =>
      (super.noSuchMethod(Invocation.getter(#title), returnValue: '')
          as String);
  @override
  String get task =>
      (super.noSuchMethod(Invocation.getter(#task), returnValue: '') as String);
  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  Map<String, dynamic> toMap() =>
      (super.noSuchMethod(Invocation.method(#toMap, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toString() => super.toString();
}
