import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/Question.dart';
import 'package:quiz_app/models/Quiz.dart';

class QuizDetailScreen extends StatefulWidget {
  QuizDetailScreen({this.quiz});
  final Quiz quiz;
  @override
  _QuizDetailScreenState createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  Quiz quiz;
  @override
  void initState() {
    quiz = widget.quiz;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          quiz.name,
          style: Theme.of(context)
              .primaryTextTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.46),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: quiz.questions.length,
        itemBuilder: (context, index) {
          return questionCard(quiz.questions[index], context);
        },
      ),
    );
  }
}

Widget questionCard(Question question, context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: question.answer == "1" ? Colors.green:Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                    ),
                    child: Center(child: Text(question.options[0],style: TextStyle(fontSize: 16,color: question.answer == "1" ? Colors.white: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: question.answer == "2" ? Colors.green:Colors.white,

                    ),
                    child: Center(child: Text(question.options[1],style: TextStyle(fontSize: 16,color: question.answer == "2" ? Colors.white: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: question.answer == "3" ? Colors.green:Colors.white,

                    ),
                    child: Center(child: Text(question.options[2],style: TextStyle(fontSize: 16,color: question.answer == "3" ? Colors.white: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: question.answer == "4" ? Colors.green:Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                    ),
                    child: Center(child: Text(question.options[3],style: TextStyle(fontSize: 16,color: question.answer == "4" ? Colors.white: Colors.black,fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
