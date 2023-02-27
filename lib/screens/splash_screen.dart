import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:frs/screens/start.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.png'), fit: BoxFit.cover),
      ),
      child: AnimatedSplashScreen(
        splash: Image(image: AssetImage('assets/splash.png')),
        nextScreen: start(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 300,
        duration: 3000,
        animationDuration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(0, 39, 39, 241),
      ),
    );
  }
}
