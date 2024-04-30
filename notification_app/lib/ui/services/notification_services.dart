import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/models/task.dart';
import 'package:notification_app/ui/notified_page.dart';
import 'package:timezone/timezone.dart' as tz;
import "dart:async";

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
   // print('Pa saber que llega');

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

scheduledNotification(Task task, String startTime) async {
  await flutterLocalNotificationsPlugin.show(
    task.id!.toInt(),
    task.title,
    task.note,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
      ),
    ),
    payload: '${task.title}|${task.note}|',
  );
}

scheduleNotificationForTask(Task task, String startTime) async {
  
     final NotifyHelper notifyHelper = NotifyHelper();
     Timer.periodic(Duration(minutes: 1), (timer) {
 final currentTime = DateTime.now();
            final startTime = task.starTime != null ? DateFormat("HH:mm").parse(task.starTime!) : DateTime(2000, 1, 1);
            if (currentTime.hour == startTime.hour && currentTime.minute == startTime.minute) {
             notifyHelper.scheduledNotification(task, task.starTime);
            }

      });
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



  Future selectNotification(String? payload) async {
    if (payload != null) {
      //print('notification payload: $payload');
    } else {
      //print("Notification Done");
    }
    if (payload == '¡Hola!') {
      //print('Goku');
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


 Future<void> scheduledNotification2(Task task, String starTime) async {
  final timeComponents = starTime.split(':');
  final int hour = int.parse(timeComponents[0]);
  final int minute = int.parse(timeComponents[1]);

  // Convertir la hora y el minuto a segundos
  final int scheduledTimeInSeconds = (hour * 3600) + (minute * 60);

  // Obtener la hora actual en segundos desde la medianoche
  final DateTime now = DateTime.now();
  final int currentTimeInSeconds = (now.hour * 3600) + (now.minute * 60) + now.second;

  // Calcular la diferencia en segundos entre la hora programada y la hora actual
  int differenceInSeconds = scheduledTimeInSeconds - currentTimeInSeconds;
  if (differenceInSeconds < 0) {
    // Si la hora programada ya pasó hoy, sumar un día
    differenceInSeconds += 24 * 3600; // 24 horas en segundos
  }

  // Convertir la diferencia en segundos a una duración
  final Duration difference = Duration(seconds: differenceInSeconds);

  // Calcular la hora de la notificación
  final notificationTime = now.add(difference);

  // Programar la notificación
  await flutterLocalNotificationsPlugin.zonedSchedule(
    task.id!.toInt(),
    task.title,
    task.note,
    tz.TZDateTime.from(notificationTime, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    payload: '${task.title}|${task.note}|',
  );
}



}
