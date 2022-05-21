import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    tz.initializeTimeZones();
 final IOSInitializationSettings initializationSettingsIOS =
     IOSInitializationSettings(
         requestSoundPermission: false,
         requestBadgePermission: false,
         requestAlertPermission: false,
         onDidReceiveLocalNotification: onDidReceiveLocalNotification
     );


 const AndroidInitializationSettings initializationSettingsAndroid =
       AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);

  }
  scheduledNotification() async {
     await flutterLocalNotificationsPlugin.zonedSchedule(
         0,
         'scheduled title',
         'theme changes 5 seconds ago',
         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name')),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime);

   }
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        icon: 'appicon',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
     Get.to((){
       return Container(color: Colors.amberAccent,);
     });
  }
   Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(const Text('Hi there'));
  }
}