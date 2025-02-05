import 'package:expense_tracker_app/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/data/app_data.dart';
import 'package:expense_tracker_app/provider/them_provider.dart';
import 'package:expense_tracker_app/screen/add_expense_screen.dart';
import 'package:expense_tracker_app/screen/login%20and%20signup/login_screen.dart';
import 'package:expense_tracker_app/screen/login%20and%20signup/signup_screen.dart';
import 'package:expense_tracker_app/screen/setting_screen.dart';
import 'package:expense_tracker_app/screen/splash_screen.dart';
import 'package:expense_tracker_app/screen/main_screen.dart';
import 'package:expense_tracker_app/screen/home_screen.dart';
import 'package:expense_tracker_app/screen/static_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ExpenseBloc(appDataBase: AppDataBase.instance),
    child: ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        /// them mode // provider
        themeMode: context.watch<ThemeProvider>().getThemeValue()
            ? ThemeMode.dark
            : ThemeMode.light,

        /// dark them
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          canvasColor: Colors.black,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 30,
            ),
            displayMedium: TextStyle(fontSize: 20),
          ),
        ),

        /// light them
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 30,
            ),
            displayMedium: TextStyle(fontSize: 20),
          ),
          canvasColor: Colors.white,
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
