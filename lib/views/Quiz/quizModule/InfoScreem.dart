import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/views/Quiz/quizModule/quizCard.dart';
import 'package:quiz_app/views/landingScreen.dart';

class InfoCard extends StatefulWidget {
  final Quiz quiz;
  const InfoCard({this.quiz});

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool loading = false;

  Quiz quiz;
  int remain = 0;

  getData() {
    setState(() {
      loading = true;
    });
    quiz = widget.quiz;
    var now = DateTime.now();
    var tempEndtDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(quiz.endTime.split(":").first),
        int.parse(quiz.endTime.split(":").last));
    remain = tempEndtDateTime.difference(now).inSeconds;
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
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 24),
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
                      height: 75,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Reward: Rs ${quiz.reward}",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      quiz.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(height: 22),
                    Text(
                      "${quiz.name}",
                      style: Theme.of(context).textTheme.headline5.copyWith(
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "No of Questions",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${quiz.questions.length}",
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
                          "Time Limit",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${quiz.minutes} min ${quiz.seconds} Sec",
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
                          "Correct Grade",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${quiz.correctScore}",
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
                          "*Incorrect Grade",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${quiz.incorrectScore}",
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
                      color: Colors.greenAccent,
                      child: Text(
                        "Start",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            DateTime start = DateTime.now();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    QuizCard(quiz: quiz, start: start),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
