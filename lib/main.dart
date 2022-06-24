// ignore_for_file: non_constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "Key1", 
        channelName: "awesomenotificationkey", 
        channelDescription: "Awesome notification",
        defaultColor: const Color(0XFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
      ),
    ]
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Notify();
            // AwesomeNotifications().actionStream.listen((recivedNotification) {
            //   print(recivedNotification);
            // });
          },
          child: const Icon(Icons.circle_notifications),
        )
      ),
    );
  }
}

void Notify() async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'Key1',
      body: 'This is Body of Notification',
      bigPicture: "https://picsum.photos/200/300",
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  print("Message from push notification is ${message.data}");

  AwesomeNotifications().createNotificationFromJsonData(message.data);
}