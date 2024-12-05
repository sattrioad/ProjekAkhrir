import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login_screen.dart';
import 'main_screen.dart';

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
