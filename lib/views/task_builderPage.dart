import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/widgets/taskListItem.dart';
import 'package:todo_app/widgets/taskModal.dart';

class TaskBuilder extends StatelessWidget {
  Todo todo;
  List<Task> tasks;

  TaskBuilder(this.todo, this.tasks);

  Widget build(BuildContext context) {
    var task_provider = Provider.of<TaskRepository>(context);

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
                  Task new_task = Task(todo_id: todo.id, timer: DateTime.now());
                  var result = await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return TaskModal(new_task, modalStatus.add);
                    },
                  );
                  if (result == null) return;
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
              SizedBox(height: 80),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 40),
                child: Hero(
                  tag: todo.id.toString() + '_description',
                  child: Text(
                    '${todo.description}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
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