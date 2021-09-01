import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/views/Quiz/quizModule/InfoScreem.dart';

import '../../landingScreen.dart';

class TimeErrorScreen extends StatefulWidget {
  final Quiz quiz;
  const TimeErrorScreen({@required this.quiz});

  @override
  _TimeErrorScreenState createState() => _TimeErrorScreenState();
}

class _TimeErrorScreenState extends State<TimeErrorScreen> {
  @override
  void initState() {
    super.initState();
    checkTime();
  }

  checkTime() async {
    var res = await AuthService.makeAuthenticatedRequest(
        "https://quizaddaplus.tk/api/app/time",
        method: "GET");
    int times = int.parse(jsonDecode(res.body)["date"].toString());
    DateTime netTime = DateTime.fromMillisecondsSinceEpoch(times);
    int diff = DateTime.now().difference(netTime).inSeconds;
    print(diff);
    if (diff > 30 || -diff > 30) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("System Time Mismatch"),
          content: Text("Please update your Phone's time!"),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => InfoCard(
            quiz: widget.quiz,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LandingScreen(
              selectedIndex: 0,
            ),
          ),
        );
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
