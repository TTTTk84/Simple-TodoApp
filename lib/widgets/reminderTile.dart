import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/selectDateTime.dart';
import 'package:todo_app/utils/util.dart';

class ReminderCardBuilder extends StatelessWidget {
  List<Task> tasklist;

  ReminderCardBuilder(this.tasklist);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasklist.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 25),
          padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0.015, 0.015],
              colors: [Colors.yellowAccent, Colors.white],
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 10.0,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tasklist[index].description,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    selectDateTime.dateTimeParse(tasklist[index].timer),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              Transform.rotate(
                angle: 0.35,
                child: Icon(
                  Icons.notifications_on,
                  color: Colors.black12,
                  size: 45,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
