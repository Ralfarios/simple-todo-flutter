import 'package:flutter/material.dart';

import 'package:simple_todo_flutter/routes/constant.dart';
import 'package:simple_todo_flutter/screens/form/form_view.dart';
import 'package:simple_todo_flutter/screens/todo_list/todo_list_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const TodoListView());
      case AppRoutes.form:
        if (args != null) {
          return MaterialPageRoute(builder: (_) => FormView(data: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Error, unknown error happens')),
      );
    });
  }
}
