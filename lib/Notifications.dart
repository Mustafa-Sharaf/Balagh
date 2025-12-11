import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';


Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  print("Background message received!");
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
}

class Notifications {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  Future<void> initNotifications() async {
    try {
      await firebaseMessaging.requestPermission();

      final token = await firebaseMessaging.getToken();
      print("Notification Token: $token");
      if (token != null) {
        GetStorage().write('fcm_token', token);
      }

      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);


      FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);


      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Foreground message received!");
        print("Title: ${message.notification?.title}");
        print("Body: ${message.notification?.body}");
        _showLocalNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("🖱️ Notification clicked!");
        print("Title: ${message.notification?.title}");
        print("Body: ${message.notification?.body}");
      });
    } catch (e) {
      print("Failed to init notifications: $e");
    }
  }


  void _showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? "Notification",
      message.notification?.body ?? "",
      platformDetails,
    );
  }
}
