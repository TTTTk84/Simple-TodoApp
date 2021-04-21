import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/util.dart';

class TaskModal extends StatelessWidget {
  Task _task;
  modalStatus status;
  TaskModal(this._task, this.status);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController(text: _task.description);
    void _onPress() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _task.description = _textController.text;
        if (status == modalStatus.add) {
          await Provider.of<TaskRepository>(context, listen: false)
              .create(_task);
        } else {
          await Provider.of<TaskRepository>(context, listen: false)
              .update(_task);
        }
        Navigator.of(context).pop<String>('${_textController.text}');
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height - 80,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height / 25,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(175, 30),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 340,
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          status == modalStatus.add ? 'タスクを追加' : 'タスクを編集',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            controller: _textController,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "腹筋",
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                            ),
                            validator: (String v) {
                              if (v.isEmpty || v == null)
                                return 'テキストを入力してください';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 38),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today_sharp,
                                size: 40,
                                color: Colors.orangeAccent,
                              ),
                              SizedBox(width: 50),
                              Text(
                                '04-31-2021',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 50,
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
                              status == modalStatus.add ? 'タスクを追加' : 'タスクを編集',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
