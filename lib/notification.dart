import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/models/task.dart';

class Notification {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  Task _task;

  Notification(this._task);

  Notification._() {
    init();
  }

  Future<void> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> updateNotification(Task _task) async {
    print('task: ${_task.description} is_enable: ${_task.is_enabled}');
    if (!_task.is_enabled) {
      cancelNotification(_task);
      return;
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('reminder', 'Reminder', 'Daily reminder');
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.schedule(
        _task.id,
        'TODOLIST',
        ' ${_task.description} の時間になりました！',
        _task.timer,
        platformChannelSpecifics);
  }

  Future<void> cancelNotification(Task _task) async {
    await _flutterLocalNotificationsPlugin.cancel(_task.id);
  }
}

Notification notificationPlugin = Notification._();
