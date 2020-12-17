import 'package:flutter/material.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/services/responseService.dart';

class RewardScreen extends StatefulWidget {
  RewardScreen({this.quiz});
  final Quiz quiz;
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadDataScreen();
  }

  List<Response> quizResponses = [];

  loadDataScreen() async {
    setState(() {
      isLoading = true;
    });
    quizResponses = await ResponseService.getResponseByQuiz(widget.quiz.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _scaffoldKey.currentState.openDrawer();
                },
              ),
              centerTitle: true,
              title: Text(
                "LeaderBoard",
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.46),
              ),
            ),
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
                            itemCount: 20,
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
                                        child: Image.network(quizResponses[index].user.photoUrl),
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
