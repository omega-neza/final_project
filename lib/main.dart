import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/components/ThemeProvider.dart';
import 'package:final_project/screens/StepCounter.dart';
import 'package:final_project/screens/lightsensor.dart';
import 'package:final_project/screens/maps.dart';
import 'package:final_project/screens/proximitysensor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
  await initNotifications();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeNotifier.currentTheme.copyWith(
        primaryColor: Colors.blue.shade900,
        hintColor: Colors.white,
        scaffoldBackgroundColor: Colors.white, // Change background color to white
      ),
      home: const MyHomePage(title: 'Smart Home Monitoring'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          title,
          style: TextStyle(color: theme.hintColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.map, color: theme.primaryColor),
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapPage())),
            ),
            Text(
              'Maps',
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.sensor_door, color: theme.primaryColor),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProximityPage())),
            ),
            Text(
              'Proximity Sensor',
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.directions_walk, color: theme.primaryColor),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StepCounterPage())),
            ),
            Text(
              'Step Counter',
              style: TextStyle(color: Colors.black),
            ),
           
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.lightbulb, color: theme.primaryColor),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LightSensorPage())),
            ),
            Text(
              'Light Sensor',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
