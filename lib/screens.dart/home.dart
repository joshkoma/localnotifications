import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

//create plugin instance and initialize
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    //initialization settings can be copied over from pub dev for flutter local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: ((id, title, body, payload) =>
                null));
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) =>
            null); //set iOS to null if you are testing on android
  }

//funciton to test notification, can be copied over from pubdev
  static Future testnotification() async {
    print('Simple notification triggered');
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(0, 'Simple notification',
        'Notification has no repeat interval', notificationDetails,
        payload: 'payload');
  }

  static Future showPeriodicNotifications() async {
    print('Periodic notification triggered');
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('test 2', 'Test 2 title',
            channelDescription: 'Test 2 description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

//repeat interval is a type of its own
    await _flutterLocalNotificationsPlugin
        .periodicallyShow(1, 'Periodic Notification', 'Repeat interval',
            RepeatInterval.everyMinute, notificationDetails,
            payload: 'payload')
        .catchError((error) {
      print('Error showing periodic notification: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Notifications'),
        ),
        body: Expanded(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: testnotification,
                  child: Text('Test Notification')),
              ElevatedButton(
                  onPressed: showPeriodicNotifications,
                  child: Text('Periodic Notification'))
            ],
          ),
        ),
      ),
    );
  }
}
