import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewTask extends StatefulWidget {
  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        right: 40,
        left: 40,
        bottom: MediaQuery.of(context).size.height / 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('タスク追加', style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 20,
          ),
          TextFormField(),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: SizedBox(
                width: 300.0,
                height: 40.0,
                child: ElevatedButton(
                  child: Text(
                    "送　信",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
