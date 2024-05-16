import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/components/themes.dart';
import 'package:final_project/pages/StepCounter.dart';
import 'package:final_project/pages/lightsensor.dart';
import 'package:final_project/pages/maps.dart';
import 'package:final_project/pages/charts.dart';
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

  const InitializationSettings initializationSettings = InitializationSettings(
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
  const MyApp({super.key});

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
  const MyHomePage({required this.title, super.key});

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
              icon: Image.asset('lib/assets/location.gif', width: 50, height: 50),
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MapPage())),
            ),
            const Text(
              'Maps',
              style: TextStyle(color: Colors.black),
            ),
            
            IconButton(
              iconSize: 50,
              icon: Image.asset('lib/assets/walk.gif', width: 50, height: 50),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StepCounterPage())),
            ),
            const Text(
              'Step Counter',
              style: TextStyle(color: Colors.black),
            ),
           
            IconButton(
              iconSize: 50,
              icon: Image.asset('lib/assets/light.gif', width: 50, height: 50),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  LightSensorPage(
                      flutterLocalNotificationsPlugin:
                          flutterLocalNotificationsPlugin,
                    ),
                  ),
                )
            ),
            const Text(
              'Light Sensor',
              style: TextStyle(color: Colors.black),
            ),

             IconButton(
              iconSize: 50,
              icon: Image.asset('lib/assets/chart.gif', width: 50, height: 50),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  RealTimeChartPage(
                    
                    ),
                  ),
                )
            ),
            const Text(
              'Light Sensor',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
