import 'package:test/test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/repository/todo_repository.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'todo_controller_test.mocks.dart';
import 'package:uuid/uuid.dart';

@GenerateMocks([], customMocks: [
  MockSpec<TodosRepository>(returnNullOnMissingStub: true),
  MockSpec<Todo>(returnNullOnMissingStub: true)
])
void main() {
  late MockTodosRepository mockRepo;

  setUp(() {
    Get.reset();
    mockRepo = MockTodosRepository();

    Get.put<TodosRepository>(mockRepo);
  });

  test('Controller will load empty list when initialized', () async {
    when(mockRepo.getAll()).thenAnswer((_) async => []);
    final controller = Get.put(TodosController());

    expect(controller.todos.length, 0);
  });

  test('Controller will load one todo', () async {
    when(mockRepo.getAll()).thenAnswer((_) async => [
          Todo(Uuid().v1(), 'test title', 'test task', false),
        ]);
    final controller = Get.put(TodosController());
    await Future.delayed(const Duration(milliseconds: 10));

    expect(controller.todos.length, 1);
  });
  test('Controller will load one user: test 2', () async {
    when(mockRepo.getAll())
        .thenAnswer((_) async => [MockTodo(), MockTodo(), MockTodo()]);
    final controller = Get.put(TodosController());
    await Future.delayed(const Duration(milliseconds: 10));

    expect(controller.todos.length, 3);
  });

  test('Delete todo works correctly', () async {
    final todoToDelete = MockTodo();
    when(mockRepo.getAll())
        .thenAnswer((_) async => [MockTodo(), MockTodo(), todoToDelete]);
    when(mockRepo.deleteTodo(any)).thenAnswer((_) async => true);

    final controller = Get.put(TodosController());
    await Future.delayed(const Duration(milliseconds: 10));

    // Before delete
    expect(controller.todos.length, 3);
    expect(controller.todos, contains(todoToDelete));

    // deleting
    await controller.deleteTodo(todoToDelete);
    expect(controller.todos.length, 2);
    expect(controller.todos, isNot(contains(todoToDelete)));
  });

/*   test('add a new todo correctly', () async {
    final newtodo = MockTodo();
    when(mockRepo.getAll()).thenAnswer((_) async => [MockTodo()]);
    when(mockRepo.addTodo(newtodo)).thenAnswer((_) async => true);

    final controller = Get.put(TodosController());
    await Future.delayed(const Duration(milliseconds: 10));

    // Before adding
    expect(controller.todos.length, 1);

    // Adding

    await controller.addTodo("", "");
    expect(controller.todos.length, 2);
  }); */
}
