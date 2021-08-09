import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/quizService.dart';
import 'package:quiz_app/services/responseService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Quiz/QuizTestScreen.dart';
import 'package:quiz_app/views/Quiz/rewardScreen.dart';
import 'package:quiz_app/views/landingScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int count = 4;
  List<Quiz> quizes = [];
  List<Response> responses = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  User user;

  bool loading = false;
  DateTime now = DateTime.now();
  List<bool> change = [];
  bool unlocked = false;
  getdata() async {
    setState(() {
      loading = true;
    });
    quizes = await QuizService.getTodaysQuiz();
    user = await UserService.getUser();
    responses = await ResponseService.getResponseByUserDate(user.id);
    change = List.filled(quizes.length, false);
    if (responses.length > 0) {
      for (int i = 0; i < responses.length; i++) {
        for (int j = 0; j < quizes.length; j++) {
          if (quizes[j].id == responses[i].quiz.id) {
            setState(() {
              change[j] = true;
            });
          }
        }
      }
    }
    try {
      if (user.subscription.validTill.difference(now).inDays > 0) {
        setState(() {
          unlocked = true;
        });
      }
    } catch (e) {
      setState(() {
        unlocked = false;
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : quizes.length > 0
            ? WillPopScope(
                onWillPop: () {
                  return Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              LandingScreen(selectedIndex: 0)));
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: ListView.builder(
                    itemCount: quizes.length,
                    itemBuilder: (context, index) {
                      return quizTile(quizes[index], index);
                    },
                  ),
                ),
              )
            : Center(
                child: Text(
                "No New Quizes",
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ));
  }

  Widget quizTile(Quiz quiz, int index) {
    var tempStartDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(quiz.startTime.split(":").first),
        int.parse(quiz.startTime.split(":").last));
    var tempEndDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(quiz.endTime.split(":").first),
        int.parse(quiz.endTime.split(":").last));
    int remain = 0;
    if (!change[index]) {
      if (now.isAfter(tempStartDateTime) && now.isBefore(tempEndDateTime)) {
        remain = tempEndDateTime.difference(now).inSeconds;
        change[index] = false;
      } else {
        change[index] = true;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: (quiz.slot == "1" ? true : unlocked)
            ? ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dynamic_form),
                  ],
                ),
                title: Text(quiz.name),
                subtitle: Row(
                  children: [
                    Icon(Icons.lock_clock),
                    remain == 0
                        ? Text("${quiz.startTime}-${quiz.endTime}")
                        : Countdown(
                            duration: Duration(seconds: remain),
                            onFinish: () {
                              setState(() {
                                change[index] = true;
                              });
                            },
                            builder: (BuildContext ctx, Duration remaining) {
                              return Text(
                                  '${remaining.inHours}:${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}');
                            },
                          ),
                  ],
                ),
                trailing: change[index]
                    ? MaterialButton(
                        child: Text(
                          'LeaderBoard',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.lightBlue.shade300,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RewardScreen(
                                quiz: quizes[index],
                              ),
                            ),
                          ).then((val) {
                            getdata();
                          });
                        },
                      )
                    : MaterialButton(
                        child: Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizTestScreen(
                                quiz: quizes[index],
                              ),
                            ),
                          ).then((value) {
                            getdata();
                          });
                        },
                      ),
              )
            : ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dynamic_form),
                  ],
                ),
                title: Text(quiz.name),
                trailing: MaterialButton(
                  child: Text(
                    'Locked',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orangeAccent,
                  onPressed: () {},
                ),
              ),
      ),
    );
  }
}
