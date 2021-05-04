import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iot_app/view/dashboard.dart';
import './my_wiget/online_image.dart';
import 'home.dart';
import 'globals.dart' as global;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  // assert(global.url = "192.168.100.7:5001");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Color(0xff00BFA5),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          // backgroundColor: Colors.grey[50],
          backgroundColor: Color(0xfffafafa),
          shadowColor: Color(0xfffafafa),
        ),
        // primaryColor: Colors.blueAccent,
      ),
      home: Home(),
    );
  }
}
