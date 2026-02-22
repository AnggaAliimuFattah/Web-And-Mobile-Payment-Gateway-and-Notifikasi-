import 'package:flutter/material.dart';
import 'package:school_ypi_new_two/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var url = 'https://tester-yipischool-admin.online/api';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Flutter Saya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(url: url), // Panggil HomePage dari home.dart
    );
  }
}
