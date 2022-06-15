import 'package:flutter/material.dart';
import 'package:fooddelivery/foodhomeui.dart';
import 'package:fooddelivery/landingpage.dart';
import 'package:fooddelivery/loginpage.dart';

void main() {
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
      home: LandingPage(),
    );
  }
}
