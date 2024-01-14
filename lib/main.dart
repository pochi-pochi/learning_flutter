import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/introduction_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroductionScreen(),
    );
  }
}
