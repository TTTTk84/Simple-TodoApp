import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/viewmodel/todo_provider.dart';
import 'package:todo_app/widgets/addTodoBottomSheet.dart';
import 'package:todo_app/widgets/appBar.dart';
import 'package:todo_app/widgets/todo_builder.dart';

class HomePage extends StatelessWidget {
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   @override
  Widget build(BuildContext context) {
    var todo_provider = Provider.of<TodoProvider>(context);
    return Container(
      child: Scaffold(
        appBar: TodoAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 3),
            Expanded(
              flex: 5,
              child: TodoBuilder(todo_provider.itemsList),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
