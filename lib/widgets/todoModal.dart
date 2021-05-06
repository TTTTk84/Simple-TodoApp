import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/util.dart';

class TodoModal extends StatelessWidget {
  Todo _todo;
  modalStatus status;

  TodoModal(this._todo, this.status);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController(text: _todo.description);
    void _onPress() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _todo.description = _textController.text;
        if (status == modalStatus.add) {
          await Provider.of<TodoRepository>(context, listen: false)
              .create(_todo.description);
        } else {
          await Provider.of<TodoRepository>(context, listen: false)
              .update(_todo);
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
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          status == modalStatus.add ? 'カテゴリを追加' : 'カテゴリを編集',
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
                              hintText: "筋トレ",
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
                              status == modalStatus.add ? 'カテゴリを追加' : 'カテゴリを編集',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
