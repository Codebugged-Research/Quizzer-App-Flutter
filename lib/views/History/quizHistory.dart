import 'package:flutter/material.dart';
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/responseService.dart';
import 'package:quiz_app/services/userService.dart';

class QuizHistory extends StatefulWidget {
  @override
  _QuizHistoryState createState() => _QuizHistoryState();
}

class _QuizHistoryState extends State<QuizHistory> {
  @override
  void initState() { 
    super.initState();
    loadDataScreen();
  }
  
  List<Response> quizResponses = [];
  User user;
  bool isLoading = false;
  loadDataScreen() async {
    setState(() {
      isLoading = true;
    });
    user = await UserService.getUser();
    quizResponses = await ResponseService.getResponseByUser(user.id);
    print(quizResponses);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: quizResponses.length > 0
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue.shade300,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0.0),
                                bottomLeft: Radius.circular(27.0),
                                bottomRight: Radius.circular(27.0),
                                topRight: Radius.circular(0.0),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green,
                                backgroundImage: NetworkImage(quizResponses[0].user.photoUrl),
                              ),
                              SizedBox(height: 10),
                              Text(
                                quizResponses.first.score,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                quizResponses.first.user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: quizResponses.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(quizResponses[index].user.photoUrl),
                                      ),
                                      title: Text(quizResponses[index].user.name),
                                      trailing: Text(quizResponses[index].score),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Center(child: Text("No Responses")),
          );
  }
}