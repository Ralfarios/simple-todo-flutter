import 'package:flutter/material.dart';
import 'package:simple_todo_flutter/models/todo_list/todo_list_model.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoListModel>();
    final removeTask = context.read<TodoListModel>().removeTask;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('#ToDo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/form', arguments: {"actionForm": 'add'});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todo.todoListLength,
          itemBuilder: (context, idx) {
            return Card(
              child: ListTile(
                title: Text(todo.todoList[idx]['todo']),
                trailing: Wrap(
                  alignment: WrapAlignment.center,
                  // spacing: 12,
                  children: [
                    IconButton(
                        splashRadius: 24,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/form', arguments: {
                            "actionForm": 'edit',
                            'todoData': todo.todoList[idx]
                          });
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        splashRadius: 24,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          AlertDialog alert = AlertDialog(
                            title: const Text('Hold up!'),
                            content: const Text(
                              'Are you sure you want to delete this"?',
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('No')),
                              TextButton(
                                onPressed: () {
                                  removeTask(todo.todoList[idx]['id']);
                                  return Navigator.pop(context, true);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => alert);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
