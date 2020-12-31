import 'dart:async';
import 'dart:convert';

import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/responseService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Member/memberScreen.dart';
import 'package:quiz_app/views/landingScreen.dart';

class QuizTestScreen extends StatefulWidget {
  QuizTestScreen({this.quiz});

  final Quiz quiz;

  @override
  _QuizTestScreenState createState() => _QuizTestScreenState();
}

class _QuizTestScreenState extends State<QuizTestScreen> {
  bool capture = false;
  int correct = 0;
  bool endTap = false;
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  Quiz quiz;
  bool readyTap = false;
  Response response;
  int reward = 0;
  double score = 0;
  DateTime start;
  DateTime stop;
  User user;
  int wrong = 0;
  int questionLength = 0;
  List<Widget> dots = [];
  PageController _pageController = PageController(initialPage: 0);
  var tempTime;
  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
    questionLength = quiz.questions.length;
    loadData();
  }

  List<int> responses = [];

  loadData() async {
    user = await UserService.getUser();
    for (int i = 0; i < questionLength; i++) {
      setState(() {
        responses.add(0);
        dots.add(Container(
          width: 16.0,
          height: 16.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ));
      });
    }
  }

  Widget dottedContainer() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dots);
  }

  Widget questionCard() {
    return PageView.builder(
      onPageChanged: (val) {
        if (responses[val] != 0) {
          setState(() {
            if (responses[val] == 1) {
              option1 = true;
            } else if (responses[val] == 2) {
              option2 = true;
            } else if (responses[val] == 3) {
              option3 = true;
            } else if (responses[val] == 4) {
              option4 = true;
            }
          });
        } else {
          setState(() {
            option1 = false;
            option2 = false;
            option3 = false;
            option4 = false;
          });
        }

        if (responses[val - 1] != 0) {
          setState(() {
            dots[val - 1] = Container(
              width: 16.0,
              height: 16.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
              ),
            );
          });
        } else {
          setState(() {
            dots[val - 1] = Container(
              width: 16.0,
              height: 16.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
              ),
            );
          });
        }
        print(val);
      },
      controller: _pageController,
      itemCount: quiz.questions.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.lightBlue.shade100.withOpacity(0.2),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  border: Border.all(
                                      color: Color(0xFFFFFFFF).withOpacity(0.6),
                                      width: 4)),
                              child: Center(
                                child: Text(
                                  "${index + 1}/${quiz.questions.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Text(
                              "${quiz.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    endTap = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock_clock,
                              color: Colors.white,
                            ),
                            Text("  Timer :  ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                            Countdown(
                              duration: Duration(
                                  minutes: int.parse(quiz.minutes),
                                  seconds: int.parse(quiz.seconds)),
                              onFinish: () {
                                setState(() {
                                  endTap = true;
                                  stop = DateTime.now();
                                  tempTime = stop.difference(start);
                                });
                              },
                              builder: (BuildContext ctx, Duration remaining) {
                                return Text(
                                  '${remaining.inHours}:${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Align(
                            alignment: Alignment.center,
                            child: dottedContainer()),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          height: UIConstants.fitToHeight(160, context),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  "${quiz.questions[index].description}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                        Shadow(
                                            offset: Offset(1, 1),
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            blurRadius: 0.1),
                                      ]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: option1 ? Colors.greenAccent : Colors.white,
                        title: Text(
                          "${quiz.questions[index].options[0]}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: option1 ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            option1 = true;
                            option2 = false;
                            option3 = false;
                            option4 = false;
                            capture = true;
                            responses[index] = 1;
                          });
                          if (quiz.questions.length == index + 1) {
                            var duration = new Duration(milliseconds: 1500);
                            return new Timer(duration, () {
                              setState(() {
                                endTap = true;
                                stop = DateTime.now();
                                tempTime = stop.difference(start);
                              });
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: option2 ? Colors.greenAccent : Colors.white,
                        title: Text(
                          "${quiz.questions[index].options[1]}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: option2 ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            option1 = false;
                            option2 = true;
                            option3 = false;
                            option4 = false;
                            capture = true;
                            responses[index] = 2;
                          });
                          if (quiz.questions.length == index + 1) {
                            var duration = new Duration(milliseconds: 1500);
                            return new Timer(duration, () {
                              setState(() {
                                endTap = true;
                                stop = DateTime.now();
                                tempTime = stop.difference(start);
                              });
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: option3 ? Colors.greenAccent : Colors.white,
                        title: Text(
                          "${quiz.questions[index].options[2]}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: option3 ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            option1 = false;
                            option2 = false;
                            option3 = true;
                            option4 = false;
                            capture = true;
                            responses[index] = 3;
                          });
                          if (quiz.questions.length == index + 1) {
                            var duration = new Duration(milliseconds: 1500);
                            return new Timer(duration, () {
                              setState(() {
                                endTap = true;
                                stop = DateTime.now();
                                tempTime = stop.difference(start);
                              });
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: option4 ? Colors.greenAccent : Colors.white,
                        title: Text(
                          "${quiz.questions[index].options[3]}",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: option4 ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            option1 = false;
                            option2 = false;
                            option3 = false;
                            option4 = true;
                            capture = true;
                            responses[index] = 4;
                          });
                          if (quiz.questions.length == index + 1) {
                            var duration = new Duration(milliseconds: 800);
                            return new Timer(duration, () {
                              setState(() {
                                endTap = true;
                                stop = DateTime.now();
                                tempTime = stop.difference(start);
                              });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget infoCard() {
    //right wrong
    var now = DateTime.now();
    var tempEndtDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(quiz.endTime.split(":").first),
        int.parse(quiz.endTime.split(":").last));
    int remain = tempEndtDateTime.difference(now).inSeconds;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
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
                height: 120,
              ),
              SizedBox(height: 12),
              Text(
                "Reward: Rs ${quiz.reward}",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                quiz.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(height: 22),
              Text(
                "${quiz.name}",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_clock,
                    color: Colors.white,
                  ),
                  Countdown(
                    duration: Duration(seconds: remain),
                    onFinish: () {
                      setState(() {
                        //pop
                      });
                    },
                    builder: (BuildContext ctx, Duration remaining) {
                      return Text(
                        '${remaining.inHours}:${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text(
                  "No of Questions",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "${quiz.questions.length}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Time Limit",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "${quiz.minutes} min ${quiz.seconds} Sec",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Correct Grade",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "${quiz.correctScore}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "*Incorrect Grade",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "${quiz.incorrectScore}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 28),
              MaterialButton(
                  height: 45,
                  minWidth: 180,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.greenAccent,
                  child: Text(
                    "Start",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      readyTap = true;
                      start = DateTime.now();
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  submit() async {
    await ResponseService.submitResponse(jsonEncode(response.toJson()));
  }

  Widget endCard() {
    for(int i = 0 ;i<quiz.questions.length;i++){
     setState(() {
       if( int.parse(quiz.questions[i].answer) == responses[i] ){
         correct ++;
       }else{
         wrong++;
       }
     });
    }
    setState(() {
      score = double.parse(quiz.incorrectScore) * wrong +
          double.parse(quiz.correctScore) * correct;
      response = Response(
          correct: correct.toString(),
          wrong: wrong.toString(),
          user: user,
          quiz: quiz,
          userRole: user.role,
          reward: reward.toString(),
          score: score.toString());
    });
    submit();

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
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
                height: 120,
              ),
              SizedBox(height: 12),
              Text(
                "Score: $score",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 22),
              Text(
                quiz.name,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
              ListTile(
                title: Text(
                  "Attempted",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  (correct + wrong).toString(),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Correct",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  (correct).toString(),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Wrong",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  (wrong).toString(),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Skipped",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "${quiz.questions.length - correct - wrong}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
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
                                    "Subscribe for more exciting quizzes and rewards"),
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
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              ));
                    } else {
                      print(user.subscription.validTill
                          .difference(DateTime.now())
                          .inDays);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LandingScreen(
                                selectedIndex: 0,
                              )));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: endTap ? endCard() : (readyTap ? questionCard() : infoCard()),
    );
  }
}
