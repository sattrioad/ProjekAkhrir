import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tokosepatu/models/user.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/currency_conversion_screen.dart';
import 'screens/time_conversion_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('userBox');
  runApp(MyApp());
  initializeBackgroundService();
}

void initializeBackgroundService() {

  FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onBackgroundServiceStart,
      isForegroundMode: true,


    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: null,
      onBackground: null,
    ),
  );
  FlutterBackgroundService().startService();
}

void onBackgroundServiceStart(ServiceInstance service) {
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Future.delayed(Duration(seconds: 3), () {
    FlutterLocalNotificationsPlugin().show(
      0,
      'Notifikasi',
      'Notifikasi ini muncul setelah 3 detik aplikasi berjalan.',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'Deskripsi Channel',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.data == true) {
          return MainScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    var box = Hive.box('userBox');
    return box.get('isLoggedIn', defaultValue: false);
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    CurrencyConversionScreen(),
    TimeConversionScreen(),
    HomeScreen(),
    FeedbackScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Currency'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Time'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
