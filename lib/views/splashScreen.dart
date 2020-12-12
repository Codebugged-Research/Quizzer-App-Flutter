import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/views/landingScreen.dart';
import 'package:quiz_app/views/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(milliseconds: 1500);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    var auth = await AuthService.getSavedAuth();
    if (auth != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LandingScreen(selectedIndex: 0);
      }));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LogInScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: UIConstants.fitToHeight(640, context),
      width: UIConstants.fitToWidth(360, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: UIConstants.fitToHeight(280, context),
            width: UIConstants.fitToWidth(280, context),
          )
        ],
      ),
    ));
  }
}
