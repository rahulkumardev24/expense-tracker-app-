import 'package:expense_tracker_app/screen/splash_screen.dart';
import 'package:expense_tracker_app/screen/main_screen.dart';
import 'package:expense_tracker_app/screen/home_screen.dart';
import 'package:expense_tracker_app/screen/static_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home : const SplashScreen()
    );
  }
}

