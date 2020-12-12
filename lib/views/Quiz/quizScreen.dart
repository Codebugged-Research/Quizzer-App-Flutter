import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/Quiz/QuizTestScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int count = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return quizTile(
              "Regular Quiz - ${index + 1}", 0, 0, 15 * (index + 1), index);
        },
      ),
    );
  }

  Widget quizTile(String title, int hr, int min, int sec, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 8),
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
//remove quiz
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text(
            '${remaining.inHours}:${remaining.inMinutes}:${remaining.inSeconds}');
      },
    );
  }
}
