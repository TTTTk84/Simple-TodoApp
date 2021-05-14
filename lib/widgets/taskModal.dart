import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/selectDateTime.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/validation/task_validation.dart';
import 'package:todo_app/utils/notification.dart';

class TaskModal extends StatelessWidget {
  final modalStatus _status;

  TaskModal(this._status);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    var _validProvider = Provider.of<TaskValidation>(context, listen: false);
    var _validTask = _validProvider.taskValidation;

    void _onPress() async {
      var _newTask = Task.useModal(_validTask);
      notificationPlugin.updateNotification(_newTask);

      if (_status == modalStatus.add) {
        await Provider.of<TaskRepository>(context, listen: false)
            .create(_newTask);
      } else {
        await Provider.of<TaskRepository>(context, listen: false)
            .update(_newTask);
      }

      Navigator.of(context).pop();
    }

    return Container(
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
                      initialValue: _validTask['description'],
                      decoration: InputDecoration(
                        hintText: "腹筋",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.normal,
                      ),
                      onChanged: (text) async {
                        await _validProvider.changeDescription(text);
                      },
                    ),
                  ),
                  SizedBox(height: deviceH * 0.03),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(38, 0, 40, 0),
                    child: Consumer<TaskValidation>(
                      builder: (_, model, __) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CupertinoSwitch(
                              value: model.taskValidation['is_enabled'],
                              onChanged: (v) async {
                                await model.changeIsEnabled();
                              },
                            ),
                            TextButton(
                              onPressed: () async {
                                var _time =
                                    await SelectDateTime(context).selectDate();
                                if (_time == null) return;
                                model.changeDateTime(_time);
                              },
                              child: Text(
                                SelectDateTime.dateTimeParse(
                                  model.taskValidation['timer'],
                                ),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
                    child: Consumer<TaskValidation>(
                      builder: (_, model, __) {
                        return ElevatedButton(
                          onPressed: (!model.isValid) ? null : _onPress,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
