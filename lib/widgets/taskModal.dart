import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/util.dart';
// import 'package:todo_app/utils/notification.dart';
// import 'package:todo_app/utils/selectDateTime.dart';

class TaskModal extends StatelessWidget {
  final Task _task;
  final modalStatus _status;

  TaskModal(this._task, this._status);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    var _provider = Provider.of<TaskRepository>(context, listen: false);

    void _onPress() async {
      var _editingTask = _provider.getEditingTask;
      print("""
      is_enabled: ${_editingTask['is_enabled']}
      description: ${_editingTask['description']}
      """);
    }

    return FutureBuilder(
      future: _provider.initEditingTask(_task, _status),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (dataSnapshot.error != null) {
          return Center(
            child: Text('エラーがおきました'),
          );
        }
        return Consumer<TaskRepository>(
          builder: (context, model, child) {
            var _editingTask = model.getEditingTask;
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
                              initialValue: _editingTask['description'],
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
                                model.editingDescription(text);
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
                                  value: _editingTask['is_enabled'],
                                  onChanged: (v) async {
                                    await model.editingIsEnable();
                                  },
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
                                _status == modalStatus.add
                                    ? 'タスクを追加'
                                    : 'タスクを編集',
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
      },
    );
  }
}
