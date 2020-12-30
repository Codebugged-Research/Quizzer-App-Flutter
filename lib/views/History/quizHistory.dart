import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  // Container(
                  //   height: 250,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //       color: Colors.lightBlue.shade300,
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(0.0),
                  //         bottomLeft: Radius.circular(27.0),
                  //         bottomRight: Radius.circular(27.0),
                  //         topRight: Radius.circular(0.0),
                  //       )),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 65,
                  //         backgroundColor: Colors.white,
                  //         foregroundColor: Colors.green,
                  //         backgroundImage: NetworkImage(quizResponses[0].user.photoUrl),
                  //       ),
                  //       SizedBox(height: 10),
                  //       Text(
                  //         quizResponses.first.score,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headline5
                  //             .copyWith(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold),
                  //       ),
                  //       SizedBox(height: 10),
                  //       Text(
                  //         quizResponses.first.user.name,
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .headline6
                  //     .copyWith(color: Colors.white),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: quizResponses.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
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
                                  backgroundImage: NetworkImage(
                                      quizResponses[index].user.photoUrl),
                                ),
                                subtitle: Text(quizResponses[index].quiz.date),
                                title: Text(quizResponses[index].quiz.name),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '₹ ${quizResponses[index].reward}   |   ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.green),
                                    ),
                                    Text(
                                      quizResponses[index].score,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
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
          : Center(
              child: Text("No Responses",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20)))),
    );
  }
}
