import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/appBarUI.dart';

import 'package:todo_app/utils/util.dart';
import 'package:todo_app/widgets/todoModal.dart';

class TodoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    TodoRepository todo_repository = Provider.of<TodoRepository>(context);
    TaskRepository task_repository =
        Provider.of<TaskRepository>(context, listen: false);
    List<Task> _tasks = task_repository.enabled_task_items;

    return GradientAppBar(
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'TODO LIST',
              style: TextStyle(
                  fontSize: deviceW * 0.055, fontWeight: FontWeight.w400),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () async {
                Todo new_todo = Todo();
                var result = await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) {
                    return TodoModal(new_todo, modalStatus.add);
                  },
                );
                if (result == null) return;
              },
            ),
          ],
        ),
      ),
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
      bottom: _tasks.isEmpty
          ? appBarBottom(
              context,
              Task(description: "予定なし", timer: DateTime.now()),
            )
          : appBarBottom(context, _tasks.first),
    );
  }
}
