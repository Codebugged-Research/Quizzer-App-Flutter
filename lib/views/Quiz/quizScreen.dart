import 'package:flutter/material.dart';
import 'package:quiz_app/views/Quiz/QuizTestScreen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context,index){
        return quizTile("Regular Quiz - ${index+1}", "11AM - 12PM");
      },
    );
  }

  Widget quizTile(String title,String timming) {
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dynamic_form),
          ],
        ),
        title: Text(title),
        subtitle: Row(
          children: [Icon(Icons.lock_clock), Text(timming)],
        ),
        trailing: FlatButton(
          child: Text(
            'Start',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.lightBlue.shade300,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizTestScreen()));
          },
        ),
      ),
    );
  }
}
