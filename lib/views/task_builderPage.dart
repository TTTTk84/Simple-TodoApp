import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/statefulWrapper.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/validation/task_validation.dart';
import 'package:todo_app/widgets/taskListItem.dart';
import 'package:todo_app/widgets/taskModal.dart';

class TaskBuilder extends StatelessWidget {
  final Todo todo;
  final List<Task> tasks;

  TaskBuilder(this.todo, this.tasks);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    var _validProvider = Provider.of<TaskValidation>(context, listen: false);
    var _taskProvider = Provider.of<TaskRepository>(context, listen: false);

    Task newTask = Task(
      description: null,
      is_enabled: false,
      is_checked: false,
      todo_id: todo.id,
      timer: DateTime.now(),
    );

    return Stack(
      children: <Widget>[
        Hero(
          tag: todo.id.toString() + '_background',
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        Container(
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                _taskProvider.refresh();
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return StatefulWrapper(
                        onInit: () async {
                          await _validProvider.initTask(
                              newTask, modalStatus.add);
                        },
                        child: TaskModal(modalStatus.add),
                      );
                    },
                  );
                },
                padding: EdgeInsets.only(right: 10),
                icon: Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(height: deviceW * 0.2),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: deviceW * 0.11),
                child: Hero(
                  tag: todo.id.toString() + '_description',
                  child: Text(
                    '${todo.description}',
                    style: TextStyle(
                        fontSize: deviceW * 0.07, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: deviceW * 0.1),
              Container(
                height: deviceH * 0.5,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return listItem(tasks[index], context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
