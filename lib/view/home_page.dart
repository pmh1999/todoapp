import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todoapp/repository/todo_repository.dart';

class MyHomePage extends GetWidget<TodosController> {
  MyHomePage({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final TodosController controller = Get.put(TodosController());
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Obx(() => ListView.builder(
              itemCount: controller.todos.value.length,
              itemBuilder: (context, index) {
                final item = controller.todos.value[index];
                return Card(
                    child: Dismissible(
                  key: Key(item.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.deleteTodo(item);
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                      title:
                          Text(controller.todos.value[index].title ?? "text"),
                      subtitle:
                          Text(controller.todos.value[index].task ?? "text"),
                      trailing: Checkbox(
                          value: controller.todos.value[index].done,
                          onChanged: (value) {
                            controller.updateTodo(index, !value!);
                          })),
                ));
              })),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openPopup(context);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: controller.filterTodos,
            currentIndex: controller.filter.value,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'All',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined),
                label: 'Completed',
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outline_blank),
                label: 'Process',
                backgroundColor: Colors.blue,
              ),
            ],
            showUnselectedLabels: true,
          ),
        ));
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Add todo",
        content: Column(
          children: <Widget>[
            TextField(
              key: const Key("title"),
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              key: const Key("task"),
              controller: taskController,
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              controller.addTodo(titleController.text, taskController.text),
              Navigator.of(context).pop(),
              titleController.clear(),
              taskController.clear(),
            },
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}

class TodosBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => TodosRepository());
    Get.lazyPut(() => TodosController());
  }
}
