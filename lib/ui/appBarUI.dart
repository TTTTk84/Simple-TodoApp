import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/selectDateTime.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/views/reminderPage.dart';

Widget appBarBottom(BuildContext context, Task _task) {
  return PreferredSize(
    preferredSize: Size.fromHeight(10),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => ReminderPage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          color: CustomColors.HeaderGreyLight,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '期限の近いタスク',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  _task.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  selectDateTime.dateTimeParse(_task.timer),
                  style: TextStyle(
                    color: Colors.white,
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
                color: Colors.white,
                size: 45,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
