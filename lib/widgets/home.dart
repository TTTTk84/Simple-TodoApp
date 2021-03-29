import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/viewmodel/todo_provider.dart';
import 'package:todo_app/widgets/add_newTodo.dart';
import 'package:todo_app/widgets/todo_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var todo_provider = Provider.of<TodoProvider>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("todo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 26.0,
              ),
              onPressed: () async {
                String result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddNewTodo();
                  },
                );
                todo_provider.createNewTodo(result);
              },
            ),
          ],
        ),
        body: TodoBuilder(todo_provider.itemsList),
      ),
    );
  }
}
