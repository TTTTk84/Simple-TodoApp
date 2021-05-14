import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/selectDateTime.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/views/reminderPage.dart';

Widget appBarBottom(BuildContext context, Task _task) {
  double deviceW = MediaQuery.of(context).size.width;
  double deviceH = MediaQuery.of(context).size.height;

  return PreferredSize(
    preferredSize: Size.fromHeight(deviceW * 0.3),
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
        margin: EdgeInsets.fromLTRB(
            deviceW * 0.03, 0, deviceW * 0.03, deviceW * 0.04),
        padding: EdgeInsets.all(deviceW * 0.03),
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
                    fontSize: deviceW * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: deviceW * 0.01),
                Text(
                  _task.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceW * 0.04,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: deviceW * 0.008),
                Text(
                  SelectDateTime.dateTimeParse(_task.timer),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceW * 0.038,
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
                size: deviceW * 0.17,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
