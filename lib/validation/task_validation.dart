import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/util.dart';

class TaskValidation with ChangeNotifier {
  Map<String, dynamic> _taskValidation = {};

  Map<String, dynamic> get taskValidation => _taskValidation;

  bool get isValid {
    if (_taskValidation['description'] != null &&
        _taskValidation['is_checked'] != null &&
        _taskValidation['is_enabled'] != null &&
        _taskValidation['timer'] != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> initTask(Task _task, modalStatus _status) async {
    if (_status == modalStatus.add) {
      _taskValidation['description'] = _task.description;
      _taskValidation['is_enabled'] = _task.is_enabled;
      _taskValidation['is_checked'] = _task.is_checked;
      _taskValidation['todo_id'] = _task.todo_id;
      _taskValidation['timer'] = _task.timer;
    } else {
      _taskValidation['id'] = _task.id;
      _taskValidation['description'] = _task.description;
      _taskValidation['is_enabled'] = _task.is_enabled;
      _taskValidation['is_checked'] = _task.is_checked;
      _taskValidation['todo_id'] = _task.todo_id;
      _taskValidation['timer'] = _task.timer;
    }
    notifyListeners();
  }

  Future<void> changeIsEnabled() async {
    _taskValidation['is_enabled'] = !_taskValidation['is_enabled'];
    notifyListeners();
  }

  Future<void> changeDescription(String text) async {
    _taskValidation["description"] = text;
    notifyListeners();
  }

  Future<void> changeDateTime(DateTime _time) async {
    _taskValidation["timer"] = _time;
    notifyListeners();
  }
}
