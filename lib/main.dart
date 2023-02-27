import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frs/screens/Dashboard.dart';
import 'package:frs/screens/activity_create.dart';
import 'package:frs/screens/calorie.dart';
import 'package:frs/screens/colorcodes.dart';
import 'package:frs/screens/health_status.dart';
import 'package:frs/screens/indicators.dart';
import 'package:frs/screens/login.dart';
import 'package:frs/screens/milestone.dart';
import 'package:frs/screens/registeration.dart';
import 'package:frs/screens/splash_screen.dart';
import 'package:frs/screens/start.dart';
import 'package:frs/screens/stepper.dart';
import 'screens/option_screen.dart';
import 'screens/bmr.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: kPrimarycolour,
      scaffoldBackgroundColor: kBackgroundcolour,
      textTheme: const TextTheme(
        headline5: TextStyle(
          color: kPrimarycolour,
          fontWeight: FontWeight.bold,
        ),
        button: TextStyle(color: kPrimarycolour),
        headline6:
            TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
    ),
    initialRoute: './',
    routes: {
      './': (context) => SplashScreen(),
      '/SignUp': (context) => SignUp(),
      '/Registration': (context) => registeration(),
      '/UserProfile': (context) => userprofile(),
      '/ActivityCreate': (context) => ActivityCreate(),
      '/OptionScreen': (context) => OptionScreen(),
      '/Bmr': (context) => Bmr(),
      '/Milestone': (context) => Milestone(),
      '/Dashboard': (context) => Dashboard(),
      '/Status': (context) => HealthStatus(),
      '/Calorie': (context) => calorie(),
      '/Indicator': (context) => Indicator(),
    },
  ));
}
