import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/model/todo.dart';

class ListItem extends StatefulWidget {
  final Todo todo;

  ListItem(this.todo);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    void _checkItem() {
      setState(() {
        Provider.of<TodoProvider>(context, listen: false)
            .changeStatus(widget.todo.id);
      });
    }

    return GestureDetector(
      onTap: () {
        _checkItem();
      },
      child: Dismissible(
        key: ObjectKey(widget.todo),
        onDismissed: (DismissDirection direction) {
          Provider.of<TodoProvider>(context, listen: false)
              .removeTodo(widget.todo.id);
        },
        background: Container(
          color: Colors.red,
          child: ListTile(
            leading: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.green,
          child: ListTile(
            trailing: Icon(Icons.check, color: Colors.white),
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
                  value: widget.todo.isCheckd,
                  onChanged: (_) => _checkItem(),
                ),
                Text(
                  widget.todo.description,
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
    );
  }
}