import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
                child: ListTile(
                    title: Text(controller.todos.value[index].title ?? "text"),
                    subtitle:
                        Text(controller.todos.value[index].task ?? "text"),
                    trailing: Checkbox(
                        value: controller.todos.value[index].done,
                        onChanged: (value) {
                          controller.updateTodo(index, !value!);
                        })),
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: controller.filterTodos,
        currentIndex: controller.filter.value,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'All',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_checked_rounded),
            label: 'Completed',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_unchecked_rounded),
            label: 'Process',
            backgroundColor: Colors.blue,
          ),
        ],
        showUnselectedLabels: true,
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    taskController.dispose();
    controller.dispose();
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Add todo",
        content: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => controller.addTodo(Todo(controller.allTodos.length,
                titleController.text, taskController.text, false)),
            child: Text(
              "Add",
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
    Get.lazyPut(() => TodosController());
  }
}
