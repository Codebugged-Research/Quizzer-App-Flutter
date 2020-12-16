import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/services/quizService.dart';
import 'package:quiz_app/views/Quiz/QuizTestScreen.dart';

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

  bool loading = false;

  getdata() async {
    setState(() {
      loading = true;
    });
    quizes = await QuizService.getTodaysQuiz();
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
                    return quizTile("${quizes[index].name}", 0, 0,
                        15 * (index + 1), index);
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

  Widget quizTile(String title, int hr, int min, int sec, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.dynamic_form),
            ],
          ),
          title: Text(title),
          subtitle: Row(
            children: [
              Icon(Icons.lock_clock),
              countDownTimmer(hr, min, sec, index)
            ],
          ),
          trailing: FlatButton(
            child: Text(
              'Start',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.orangeAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizTestScreen()));
            },
          ),
        ),
      ),
    );
  }

  Widget countDownTimmer(hr, min, sec, index) {
    return Countdown(
      duration: Duration(seconds: sec, hours: hr, minutes: min),
      onFinish: () {
        quizes.removeAt(index);
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text(
            '${remaining.inHours}:${remaining.inMinutes}:${remaining.inSeconds}');
      },
    );
  }
}
