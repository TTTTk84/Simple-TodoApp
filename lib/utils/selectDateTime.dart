import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SelectDateTime {
  BuildContext context;
  SelectDateTime(this.context);

  Future<DateTime> selectDate() async {
    final DateTime selected = await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: DateTime.now(),
    );
    return selected;
  }

  static String dateTimeParse(DateTime _time) {
    List<String> _t = [];

    String Function(int v) formatCheck = (v) {
      if (v ~/ 10 != 0) {
        return "$v";
      }
      return "0$v";
    };

    _t.addAll(
      [
        "${_time.month}",
        "${formatCheck(_time.day)}",
        formatCheck(_time.hour),
        formatCheck(_time.minute)
      ],
    );
    String _format = '${_t[0]}/${_t[1]}  ${_t[2]}:${_t[3]}';
    return _format;
  }
}
