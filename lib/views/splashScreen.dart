import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
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
    var duration = new Duration(seconds: 300);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return LogInScreen();
    }));
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
        children: [Image.asset('name'), Text('Learning bhi Earning bhi')],
      ),
    ));
  }
}
