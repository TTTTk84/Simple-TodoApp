import 'package:flutter/material.dart';

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
        ),
        body: TodoBuilder(todo_provider.itemsList),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            var tmp = [
              Task("test1"),
              Task("test2"),
            ];
            todo_provider.createNewTodo(Todo(title: "temp", tasks: tmp));
          },
        ),
      ),
    );
  }
}
