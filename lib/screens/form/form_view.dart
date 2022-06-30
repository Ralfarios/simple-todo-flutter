import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_flutter/models/form/form_model.dart';
import 'package:simple_todo_flutter/models/todo_list/todo_list_model.dart';

class FormView extends StatelessWidget {
  FormView({Key? key, this.data}) : super(key: key);
  final dynamic data;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addTask = context.read<TodoListModel>().addTask;
    final editTask = context.read<TodoListModel>().editTask;
    final todoData = data['todoData'];
    final actionForm = data['actionForm'];
    FormModel model = FormModel();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${data['actionForm'] == 'add' ? 'Add' : 'Edit'} #ToDo'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: actionForm == 'edit' ? todoData['todo'] : '',
                  decoration: InputDecoration(
                    hintText: "Learning NextJS",
                    labelText: "Todo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onSaved: (String? val) {
                    model.todo = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please insert what you are going to do';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (actionForm == 'add') {
                            addTask(model.todo as String);
                          } else if (actionForm == 'edit') {
                            editTask(model.todo as String, todoData['id']);
                          }
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        }
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Cancel')),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
