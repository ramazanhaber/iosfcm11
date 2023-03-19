import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static get onDidReceiveLocalNotification => null;

  static void initialize() {
    try{
      // initializationSettings  for Android


      const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

      IOSInitializationSettings iosInitializationSettings =
      IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );

      final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings,
      );

      _notificationsPlugin.initialize(
        settings,
        onSelectNotification: (String? id) async {
        },
      );


    }catch(ex){
      print("hst "+ex.toString());
    }
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      var _messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await _messaging.requestPermission(
          alert: true, badge: true, sound: true, provisional: false);

      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "egitimbildirim",
          "egitimbildirimchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title!+" aa",
        message.notification!.body,
        notificationDetails,
        //payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}