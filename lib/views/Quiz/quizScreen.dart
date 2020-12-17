import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/quizService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Quiz/QuizTestScreen.dart';
import 'package:quiz_app/views/Quiz/rewardScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int count = 4;
  List<Quiz> quizes = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  User user;

  bool loading = false;
  DateTime now = DateTime.now();
  List<bool> change = [false, false, false, false, false];
  bool unlocked = false;
  getdata() async {
    setState(() {
      loading = true;
    });
    quizes = await QuizService.getTodaysQuiz();
    user = await UserService.getUser();
    try{if (user.subscription.validTill.difference(now).inDays > 0) {
      setState(() {
        unlocked = true;
      });
    }} catch(e) {
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
            ? Scaffold(
                backgroundColor: Colors.white,
                body: ListView.builder(
                  itemCount: quizes.length,
                  itemBuilder: (context, index) {
                    return quizTile(quizes[index], index);
                  },
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
    int hr = 0;
    int min = 0;
    int sec = 0;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: (index == 0 ? true : unlocked)
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
                    countDownTimmer(hr, min, sec, index)
                  ],
                ),
                trailing: change[index]
                    ? FlatButton(
                        child: Text(
                          'LeaderBoard',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.lightBlue.shade300,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RewardScreen()));
                        },
                      )
                    : FlatButton(
                        child: Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.orangeAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizTestScreen()));
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
                trailing: FlatButton(
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

  Widget countDownTimmer(hr, min, sec, index) {
    return Countdown(
      duration: Duration(seconds: sec, hours: hr, minutes: min),
      onFinish: () {
        setState(() {
          change[index] = true;
        });
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text(
            '${remaining.inHours}:${remaining.inMinutes}:${remaining.inSeconds}');
      },
    );
  }
}
