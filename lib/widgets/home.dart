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
          title: Text("TODO LIST"),
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
                    return AddNewTodo(AddDialogStatus.add_todo);
                  },
                );
                todo_provider.createNewTodo(result);
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    const Color(0xffe4a972).withOpacity(0.6),
                    const Color(0xFFDE4435).withOpacity(0.6),
                  ],
                  stops: const [
                    0.0,
                    1.0,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text(
                    '合計${todo_provider.itemsList.length}件',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text(
                    '完了済み${todo_provider.clearTodo()}件',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Flexible(
                  flex: 11,
                  child: TodoBuilder(todo_provider.itemsList),
                ),
                Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
