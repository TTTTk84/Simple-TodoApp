import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/validation/todo_validation.dart';

class TodoModal extends StatelessWidget {
  final modalStatus status;

  TodoModal(this.status);

  @override
  Widget build(BuildContext context) {
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    var _validProvider = Provider.of<TodoValidation>(context, listen: false);
    var _validTodo = _validProvider.todoValidation;

    void _onPress() async {
      var _newTodo = Todo.fromMap(_validTodo);

      if (status == modalStatus.add) {
        await Provider.of<TodoRepository>(context, listen: false)
            .create(_newTodo.description);
      } else {
        await Provider.of<TodoRepository>(context, listen: false)
            .update(_newTodo);
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
          SingleChildScrollView(
            child: Form(
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
                  SizedBox(height: deviceH * 0.01),
                  Container(
                    width: deviceW * 0.8,
                    child: TextFormField(
                      initialValue: _validTodo["description"],
                      decoration: InputDecoration(
                        hintText: "筋トレ",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.normal,
                      ),
                      onChanged: (text) {
                        _validProvider.changeDescription(text);
                      },
                    ),
                  ),
                  SizedBox(height: deviceH * 0.03),
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
                      onPressed: (!_validProvider.isValid) ? null : _onPress,
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
          ),
        ],
      ),
    );
  }
}
