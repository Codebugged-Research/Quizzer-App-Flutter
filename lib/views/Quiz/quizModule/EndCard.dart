import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/responseService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Member/memberScreen.dart';
import 'package:quiz_app/views/Quiz/rewardScreen.dart';

import '../../landingScreen.dart';

class EndCard extends StatefulWidget {
  final Quiz quiz;
  final Duration tempTime;
  final List<int> responses;
  const EndCard({@required this.quiz, @required this.tempTime, @required this.responses});
  @override
  _EndCardState createState() => _EndCardState();
}

class _EndCardState extends State<EndCard> {
  Quiz quiz;
  Duration tempTime;
  int reward = 0;
  double score = 0;
  int wrong = 0;
  int correct = 0;
  User user;
  Response response;
  List<int> responses = [];
  bool loading;

  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
    tempTime = widget.tempTime;
    responses = widget.responses;
    sendResponse();
  }

  sendResponse() async{
    setState(() {      
    loading = true;
    });
    for (int i = 0; i < quiz.questions.length; i++) {
      if (int.parse(quiz.questions[i].answer) == responses[i]) {
        correct++;
      } else {
        wrong++;
      }
    }
    print(correct.toString() + "--");
    print(wrong.toString() + "--");    
    user = await UserService.getUser();
    score = double.parse(quiz.incorrectScore) * wrong +
        double.parse(quiz.correctScore) * correct;
    response = Response(
        correct: correct.toString(),
        wrong: wrong.toString(),
        user: user,
        quiz: quiz,
        date:
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
        userRole: user.role,
        reward: reward.toString(),
        score: score);
    ResponseService.submitResponse(jsonEncode(response.toJson()));
    setState(() {      
    loading = true;
    });
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 36),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue.shade400,
                    Colors.lightBlue.shade300,
                    Colors.lightBlue.shade200
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/label.png",
                    height: 110,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Score: $score",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 22),
                  Text(
                    quiz.name,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_clock,
                        color: Colors.white,
                      ),
                      Text("  TimeTaken :  ",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(
                        "${tempTime.inHours}:${tempTime.inMinutes.remainder(60)}:${tempTime.inSeconds.remainder(60)}",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attempted",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (correct + wrong).toString(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Correct",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (correct).toString(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wrong",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (wrong).toString(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Skipped",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${quiz.questions.length - correct - wrong}",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  MaterialButton(
                      height: 45,
                      minWidth: 180,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.orangeAccent,
                      child: Text(
                        "LeaderBoard ",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (user.subscription == null) {
                          showDialog(
                              context: (context),
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    content: Text(
                                        "You could have won cash prizes. Be a plus member  and earn rewards!"),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MemberScreen()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2),
                                          child: Text("Subscribe",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                        ),
                                        color: Colors.lightBlue.shade300,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LandingScreen(
                                                        selectedIndex: 0,
                                                      )));
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  RewardScreen(
                                                quiz: quiz,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("Skip"),
                                      ),
                                    ],
                                  ));
                        } else {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LandingScreen(
                                    selectedIndex: 0,
                                  )));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => RewardScreen(
                                quiz: quiz,
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(height: 28),
                  MaterialButton(
                      height: 45,
                      minWidth: 180,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.greenAccent,
                      child: Text(
                        "Back to Home",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (user.subscription == null) {
                          showDialog(
                              context: (context),
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    content: Text(
                                        "You could have won cash prizes. Be a plus member  and earn rewards!"),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MemberScreen(),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2),
                                          child: Text("Subscribe",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                        ),
                                        color: Colors.lightBlue.shade300,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LandingScreen(
                                                        selectedIndex: 0,
                                                      )));
                                        },
                                        child: Text("Skip"),
                                      ),
                                    ],
                                  ));
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LandingScreen(
                                selectedIndex: 0,
                              ),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
