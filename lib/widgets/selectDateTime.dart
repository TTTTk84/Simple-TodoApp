import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class selectDateTime {
  BuildContext context;
  selectDateTime(this.context);

  Future<DateTime> selectDate() async {
    final DateTime selected = await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: DateTime.now(),
    );
    return selected;
  }

  static String dateTimeParse(DateTime _time) {
    String _format =
        '${_time.month}/${_time.day}  ${_time.hour}:${_time.minute}';
    return _format;
  }
}
