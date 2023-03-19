import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'LocalNotificationService.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  // print(message.data.toString());
  // print(message.notification!.title);
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try{
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();
    //(sonradan eklendi) Update the iOS foreground notification presentation options to allow heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,

    );

    var _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, sound: true, provisional: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      print("IOS TOKEN : " + (token ?? ""));
    }

  }catch(ex){
  }

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // rambo
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }}