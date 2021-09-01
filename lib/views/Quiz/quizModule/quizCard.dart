import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/views/Quiz/quizModule/EndCard.dart';
import 'package:quiz_app/views/landingScreen.dart';

class QuizCard extends StatefulWidget {
  final Quiz quiz;
  final DateTime start;
  const QuizCard({@required this.quiz, @required this.start});

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  Quiz quiz;
  DateTime start;
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  List<Widget> dots = [];
  List<int> responses = [];
  bool pageLoading = false;
  var tempTime;
  DateTime stop;
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
    start = widget.start;
    loadData();
  }

  loadData() async {
    for (int i = 0; i < quiz.questions.length; i++) {
      setState(() {
        responses.add(0);
        dots.add(Container(
          width: 16.0,
          height: 16.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[600],
          ),
        ));
      });
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
          body: Stack(
        children: [
          PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (val) {
              setState(() {
                option1 = false;
                option2 = false;
                option3 = false;
                option4 = false;
                dots[val] = Container(
                  width: 16.0,
                  height: 16.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                );
              });
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
              }
              setState(() {
                pageLoading = false;
              });
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
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Stack(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          border: Border.all(
                                              color: Color(0xFFFFFFFF)
                                                  .withOpacity(0.6),
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
                                    trailing: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22)),
                                                  content: Text(
                                                      "Do you want to submit your responses?"),
                                                  actions: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          stop = DateTime.now();
                                                          tempTime =
                                                              stop.difference(
                                                                  start);
                                                        });
                                                        Navigator.pop(context);
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EndCard(
                                                              quiz: quiz,
                                                              responses:
                                                                  responses,
                                                              tempTime:
                                                                  tempTime,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 2),
                                                        child: Text("Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      color: Colors
                                                          .lightBlue.shade300,
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("No"),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: UIConstants.fitToHeight(
                                            16, context)),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "${quiz.name}",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: dottedContainer()),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              Container(
                                height: UIConstants.fitToHeight(170, context),
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
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  blurRadius: 0.1),
                                            ]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005),
                            ],
                          ),
                        ),
                      ),
                      pageLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    tileColor: option1
                                        ? Colors.greenAccent
                                        : Colors.white,
                                    title: Text(
                                      "${quiz.questions[index].options[0]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: option1
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        option1 = true;
                                        option2 = false;
                                        option3 = false;
                                        option4 = false;
                                        responses[index] = 1;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    tileColor: option2
                                        ? Colors.greenAccent
                                        : Colors.white,
                                    title: Text(
                                      "${quiz.questions[index].options[1]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: option2
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        option1 = false;
                                        option2 = true;
                                        option3 = false;
                                        option4 = false;
                                        responses[index] = 2;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    tileColor: option3
                                        ? Colors.greenAccent
                                        : Colors.white,
                                    title: Text(
                                      "${quiz.questions[index].options[2]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: option3
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        option1 = false;
                                        option2 = false;
                                        option3 = true;
                                        option4 = false;
                                        responses[index] = 3;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    tileColor: option4
                                        ? Colors.greenAccent
                                        : Colors.white,
                                    title: Text(
                                      "${quiz.questions[index].options[3]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: option4
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        option1 = false;
                                        option2 = false;
                                        option3 = false;
                                        option4 = true;
                                        responses[index] = 4;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          if (responses[index] != 0) {
                                            setState(() {
                                              dots[index] = Container(
                                                width: 16.0,
                                                height: 16.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.greenAccent,
                                                ),
                                              );
                                            });
                                          } else {
                                            setState(() {
                                              dots[index] = Container(
                                                width: 16.0,
                                                height: 16.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.orangeAccent,
                                                ),
                                              );
                                            });
                                          }
                                          setState(() {
                                            pageLoading = true;
                                          });
                                          _pageController.animateToPage(
                                              index - 1,
                                              duration:
                                                  Duration(milliseconds: 800),
                                              curve: Curves.easeInOut);
                                        },
                                        color: Colors.lightBlue.shade300,
                                        height: 48,
                                        minWidth: 100,
                                        child: Icon(Icons.arrow_back_ios,
                                            color: Colors.white),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          if (responses[index] != 0) {
                                            setState(() {
                                              dots[index] = Container(
                                                width: 16.0,
                                                height: 16.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.greenAccent,
                                                ),
                                              );
                                            });
                                          } else {
                                            setState(() {
                                              dots[index] = Container(
                                                width: 16.0,
                                                height: 16.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.orangeAccent,
                                                ),
                                              );
                                            });
                                          }
                                          if (quiz.questions.length ==
                                              index + 1) {
                                            showDialog(
                                              context: (context),
                                              builder: (context) => AlertDialog(
                                                title: Text("Alert"),
                                                content: Text(
                                                    "Do you want to submit your response now?"),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        stop = DateTime.now();
                                                        tempTime = stop
                                                            .difference(start);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EndCard(
                                                            quiz: quiz,
                                                            responses:
                                                                responses,
                                                            tempTime: tempTime,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 2),
                                                      child: Text("Yes",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    color: Colors
                                                        .lightBlue.shade300,
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("No"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              pageLoading = true;
                                            });
                                            _pageController.animateToPage(
                                                index + 1,
                                                duration:
                                                    Duration(milliseconds: 800),
                                                curve: Curves.easeInOut);
                                          }
                                        },
                                        color: Colors.lightBlue.shade300,
                                        height: 48,
                                        minWidth: 100,
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(top: UIConstants.fitToHeight(28, context)),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_clock,
                  color: Colors.white,
                ),
                Text("  Timer :  ",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Countdown(
                  duration: Duration(
                      minutes: int.parse(quiz.minutes),
                      seconds: int.parse(quiz.seconds)),
                  onFinish: () {
                    setState(() {
                      stop = DateTime.now();
                      tempTime = stop.difference(start);
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => EndCard(
                          quiz: quiz,
                          responses: responses,
                          tempTime: tempTime,
                        ),
                      ),
                    );
                  },
                  builder: (context, Duration remaining) {
                    return Text(
                      '${remaining.inHours}:${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget dottedContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dots,
    );
  }
}
