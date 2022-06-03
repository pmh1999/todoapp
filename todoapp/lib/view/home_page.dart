import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/viewmodel/viewmodel.dart';
import 'package:todoapp/model/todo.dart';

class MyHomePage extends GetWidget<TodosController> {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodosController controller = Get.put(TodosController());

    return Scaffold(
        body: SafeArea(
      child:
           Obx(() => ListView.builder(
                    itemCount: controller.todos.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text(controller.todos[index].title!),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => controller
                              .deleteTodo(controller.todos[index].id!)),
                    ))),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addTodo("Test", "test");
// Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.plus_one),
      ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.filterTodos,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              label: 'All',
              backgroundColor: Colors.blue,
              activeIcon: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: Container(
                    color: const Color(0xff8E97FD),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.plus_one),
                    ),
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              label: 'Completed',
              backgroundColor: Colors.blue,
              activeIcon: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: Container(
                    color: const Color(0xff8E97FD),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.plus_one),
                    ),
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              label: 'Process',
              backgroundColor: Colors.blue,
              activeIcon: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: Container(
                    color: const Color(0xff8E97FD),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.plus_one),
                    ),
                  )),
            ),
          ],
          showUnselectedLabels: true,
        ),
    );
  }
}
