import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/util.dart';

class TodoValidation with ChangeNotifier {
  Map<String, dynamic> _todoValidation = {};

  Map<String, dynamic> get todoValidation => _todoValidation;

  bool get isValid {
    if (_todoValidation['description'] == null ||
        _todoValidation['description'] == "") {
      return false;
    } else {
      return true;
    }
  }

  Future<void> initTodo(Todo _todo, modalStatus _status) async {
    if (_status == modalStatus.add) {
      _todoValidation['description'] = _todo.description;
      _todoValidation['createdAt'] = _todo.createdAt;
      _todoValidation['updatedAt'] = _todo.updatedAt;
    } else {
      _todoValidation['id'] = _todo.id;
      _todoValidation['description'] = _todo.description;
      _todoValidation['createdAt'] = _todo.createdAt;
      _todoValidation['updatedAt'] = _todo.updatedAt;
    }
  }

  Future<void> changeDescription(String text) async {
    _todoValidation['description'] = text;
    notifyListeners();
  }
}
