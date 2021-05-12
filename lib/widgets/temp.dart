import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/utils/notification.dart';
import 'package:todo_app/utils/selectDateTime.dart';

class TaskModal extends StatelessWidget {
  final Task _task;
  final modalStatus _status;

  TaskModal(this._task, this._status);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    var _provider = Provider.of<TaskRepository>(context, listen: false);
    var editingTask = _provider.getEditingTask;

    _provider.initEditingTask(_task, _status);

    void _onPress() async {
      if (editingTask['description'].isEmpty ||
          editingTask['description'] == null) return;

      var _newTask = Task.fromMap(editingTask);

      notificationPlugin.updateNotification(_newTask);
      if (_status == modalStatus.add) {
        await _provider.create(_newTask);
      } else {
        await _provider.update(_newTask);
      }
      Navigator.of(context).pop<String>('${_newTask.description}');
    }

    return Consumer<TaskRepository>(
      builder: (context, model, child) {
        Container(
          height: deviceH * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(175, 30),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: deviceW * 0.08),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: deviceW * 0.15,
                  height: deviceW * 0.15,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        CustomColors.PurpleLight,
                        CustomColors.PurpleDark,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.PurpleShadow,
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        _status == modalStatus.add ? 'タスクを追加' : 'タスクを編集',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: deviceH * 0.01),
                      Container(
                        width: deviceW * 0.8,
                        child: TextFormField(
                          initialValue: editingTask['description'],
                          decoration: InputDecoration(
                            hintText: "腹筋",
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                          ),
                          onChanged: (text) {
                            _provider.editingDescription(text);
                          },
                        ),
                      ),
                      SizedBox(height: deviceH * 0.03),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(38, 0, 40, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CupertinoSwitch(
                              value: editingTask['is_enabled'],
                              onChanged: (v) async {
                                await _provider.editingIsEnable();
                              },
                            ),
                            TextButton(
                              onPressed: () async {
                                var temp =
                                    await SelectDateTime(context).selectDate();
                                if (temp == null) return;
                                editingTask['timer'] = temp;
                              },
                              child: Text(
                                SelectDateTime.dateTimeParse(
                                    editingTask['timer']),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: deviceH * 0.08,
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: FractionalOffset.bottomRight,
                            end: FractionalOffset.topLeft,
                            colors: [
                              const Color(0xFF6A8FFF).withOpacity(0.6),
                              const Color(0xFF1111E6).withOpacity(0.6),
                            ],
                            stops: const [
                              0.0,
                              1.0,
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _onPress();
                          },
                          child: Text(
                            _status == modalStatus.add ? 'タスクを追加' : 'タスクを編集',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
