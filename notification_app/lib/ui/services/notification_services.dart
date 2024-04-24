import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:notification_app/models/task.dart';
import 'package:notification_app/ui/notified_page.dart';
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotifyHelper() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> initializeNotification() async {
    //_configureLocalTimeZone();
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );

    // Solicitar permisos de notificación para Android
    await requestAndroidPermissions();
    // Solicitar permisos de notificación para iOS
    await requestIOSPermissions();
  }

  Future<void> requestAndroidPermissions() async {
    const settings = AndroidNotificationChannel(
      'your channel id',
      'your channel name',
      //'your channel description',
      importance: Importance.max,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(settings);
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> displayNotification({
    required String title,
    required String body,
  }) async {
    print('Pa saber que llega');

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      //'your channel description',
      importance: Importance.max,
      playSound: true,
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  scheduledNotification(int hora, int min, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _convertTime(hora, min),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '${task.title}|${task.note}|',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            //'your channel description',
          ),
        ));
  }

  tz.TZDateTime _convertTime(int hora, int min) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hora, min);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /*Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }*/

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if (payload == '¡Hola!') {
      print('Goku');
    } else {
      Get.to(() => NotifiedPage(Label: payload));
      return Future.value();
    }
  }

  Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    Get.dialog(const Text("Hola Mundo"));
  }
}
