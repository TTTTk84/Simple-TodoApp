import 'package:flutter/cupertino.dart';

class TodoList extends StatelessWidget {
  String title;

  TodoList(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("$title"),
    );
  }
}
