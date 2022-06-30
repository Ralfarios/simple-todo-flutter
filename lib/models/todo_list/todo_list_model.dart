import 'package:flutter/material.dart';

class TodoListModel with ChangeNotifier {
  List<Map<String, dynamic>> _todoList = [
    {"id": 1, "todo": 'Learn Flutter'},
    {"id": 2, "todo": 'Learn Provider'},
    {"id": 3, "todo": 'Making Todo with Flutter'}
  ];

  List<Map<String, dynamic>> get todoList => _todoList;
  int get todoListLength => _todoList.length;

  set todoList(List<Map<String, dynamic>> data) {
    _todoList = data;
    notifyListeners();
  }

  void removeTask(int id) {
    List<Map<String, dynamic>> newTodos = [];

    for (var i in _todoList) {
      if (i['id'] != id) {
        newTodos.add(i);
      }
    }

    _todoList = newTodos;
    notifyListeners();
  }

  void addTask(String todo) {
    _todoList.add({'id': DateTime.now().millisecondsSinceEpoch, 'todo': todo});
    notifyListeners();
  }

  void editTask(String todo, int id) {
    for (var i in _todoList) {
      if (i['id'] == id) {
        i['todo'] = todo;
      }
    }
    notifyListeners();
  }
}
