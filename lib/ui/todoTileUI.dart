import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/widgets/todoModal.dart';

Widget todoTileUI(Todo _todo, BuildContext context) {
  double deviceW = MediaQuery.of(context).size.width;
  double deviceH = MediaQuery.of(context).size.height;
  var todo_provider = Provider.of<TodoRepository>(context);
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(deviceW * 0.019, deviceW * 0.02),
        ),
      ],
    ),
    margin: EdgeInsets.fromLTRB(deviceW * 0.1, 0, 0, deviceW * 0.015),
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Hero(
                tag: _todo.id.toString() + '_background',
                child: Container(
                  width: deviceW * 0.4,
                  height: deviceH * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        const Color(0xFF1111E6).withOpacity(0.6),
                        const Color(0xFF6A8FFF).withOpacity(0.6),
                      ],
                      stops: const [
                        0.0,
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 1,
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white38,
                  ),
                  itemBuilder: (context) => <PopupMenuEntry<TodoCardSettings>>[
                    PopupMenuItem(
                      child: Text("編集"),
                      value: TodoCardSettings.edit,
                    ),
                    PopupMenuItem(
                      child: Text("削除"),
                      value: TodoCardSettings.delete,
                    ),
                  ],
                  onSelected: (setting) async {
                    switch (setting) {
                      case TodoCardSettings.edit:
                        String result = await showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) {
                            return TodoModal(_todo, modalStatus.edit);
                          },
                        );
                        if (result == null) return;
                        break;
                      case TodoCardSettings.delete:
                        await todo_provider.delete(_todo);
                        break;
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Hero(
                  tag: _todo.id.toString() + '_description',
                  child: Text(
                    _todo.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: deviceW * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
