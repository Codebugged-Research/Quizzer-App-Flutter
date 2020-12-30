import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizDetailScreen extends StatefulWidget {
  @override
  _QuizDetailScreenState createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [Text("\n\n\n\n\n\n\n\n\n\n\n\n")],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
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
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                        ),
                        child: Center(child: Text("option1")),
                      ),
                      Container(
                        height: 48,
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                        ),
                        child: Center(child: Text("option2")),
                      ),Container(
                        height: 48,
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                        ),
                        child: Center(child: Text("option3")),
                      ),Container(
                        height: 48,
                        width:  MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                        ),
                        child: Center(child: Text("option4")),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
