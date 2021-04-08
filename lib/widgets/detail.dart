import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/viewmodel/todo_provider.dart';
import 'package:todo_app/widgets/addTodoBottomSheet.dart';

class DetailPage extends StatefulWidget {
  Todo _todo;

  DetailPage(this._todo);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var todo_provider = Provider.of<TodoProvider>(context);

    Widget listItem(int index) {
      Task _task = widget._todo.tasks[index];
      return Card(
        child: GestureDetector(
          onTap: () {
            todo_provider.checkedTask(widget._todo, _task);
          },
          child: Dismissible(
            key: ObjectKey(_task),
            onDismissed: (direction) {
              todo_provider.deleteTask(widget._todo, _task);
            },
            background: Container(
              color: Colors.red,
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 4.0,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  child: Row(children: [
                    Checkbox(
                      value: _task.is_checked,
                      onChanged: (_) {
                        todo_provider.checkedTask(widget._todo, _task);
                      },
                    ),
                    Text(
                      _task.task,
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xFF6A8FFF),
          appBar: AppBar(
            backgroundColor: Color(0xFF1111E6).withOpacity(0.4),
            elevation: 0.0,
            title: Text('${widget._todo.description}'),
            leading: Material(
              color: Colors.transparent,
              type: MaterialType.transparency,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 26.0,
                ),
                onPressed: () async {
                  String result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //return AddNewTodo(AddDialogStatus.add_task);
                    },
                  );
                  todo_provider.createNewTask(widget._todo, result);
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: widget._todo.tasks.length,
            itemBuilder: (context, index) {
              return listItem(index);
            },
          ),
        )
      ],
    );
  }
}
