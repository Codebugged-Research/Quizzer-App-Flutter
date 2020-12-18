import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_app/models/File.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/fileService.dart';
import 'package:quiz_app/services/quizService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Home/Carousel/itemFour.dart';
import 'package:quiz_app/views/Home/Carousel/itemOne.dart';
import 'package:quiz_app/views/Home/Carousel/itemThree.dart';
import 'package:quiz_app/views/Home/Carousel/itemTwo.dart';
import 'package:quiz_app/views/Quiz/QuizTestScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String name = '';
  String email = '';
  User user;
  List<Quiz> quizes = [];
  List<Files> files = [];
  Quiz quiz1;
  Quiz quiz2;
  Quiz quiz3;
  Quiz quiz4;
  Quiz quiz5;
  bool subscribed = false;
  List cardList = [Item1(), Item2(), Item3(), Item4()];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  bool loading = false;
  @override
  void initState() {
    super.initState();
    loadDataForUser();
  }

  loadDataForUser() async {
    setState(() {
      loading = true;
    });
    var auth = await AuthService.getSavedAuth();
    user = await UserService.getUser();
    try {
      files = await FileService.getAllFile();
    } catch (e) {
      print(e);
    }
    DateTime now = DateTime.now();
    try {
      if (user.subscription.validTill.difference(now).inDays > 0) {
        setState(() {
          subscribed = true;
        });
      }
    } catch (e) {
      setState(() {
        subscribed = false;
      });
    }

    setState(() {
      name = auth['name'];
      email = auth['email'];
    });
    quizes = await QuizService.getTodaysQuiz();
    setState(() {
      quizes.forEach((element) {
        var tempStartDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(element.startTime.split(":").first),
            int.parse(element.startTime.split(":").last));
        var tempEndtDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(element.endTime.split(":").first),
            int.parse(element.endTime.split(":").last));

        if (element.slot == '1') {
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            quiz1 = element;
          } else {
            quiz1 = null;
          }
        } else if (element.slot == '2') {
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            quiz2 = element;
          } else {
            quiz2 = null;
          }
        } else if (element.slot == '3') {
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            quiz3 = element;
          } else {
            quiz3 = null;
          }
        } else if (element.slot == '4') {
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            quiz4 = element;
          } else {
            quiz4 = null;
          }
        } else if (element.slot == '5') {
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            quiz5 = element;
          } else {
            quiz5 = null;
          }
        }
      });
    });
    setState(() {
      loading = false;
    });
  }

  final GlobalKey<ScaffoldState> scaffkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            key: scaffkey,
            extendBody: true,
            backgroundColor: Colors.white,
            body: Container(
              height: UIConstants.fitToHeight(640, context),
              width: UIConstants.fitToWidth(360, context),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: carouselSlider(context),
                    ),
                    carouselDots(context),
                    SizedBox(height: 30),
                    Container(
                        height: 360,
                        width: 360,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.lightBlue.shade300,
                                          ),
                                          height: 150,
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/unlocked.png",
                                                height: 56,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Quiz 1",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: quiz1 == null
                                          ? () {
                                              scaffkey.currentState
                                                  .showSnackBar(SnackBar(
                                                      duration: Duration(
                                                          milliseconds: 150),
                                                      content: Text(
                                                          "Quiz not Started or Quiz Finished!")));
                                            }
                                          : () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return QuizTestScreen(
                                                    quiz: quiz1);
                                              }));
                                            },
                                    ),
                                    SizedBox(width: 12),
                                    GestureDetector(
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.lightBlue.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                height: 150,
                                                width: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/locked.png",
                                                      height: 56,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text("Quiz 2",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      height: 150,
                                                      width: 150,
                                                    )
                                                  : Container(),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      height: 150,
                                                      width: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.lock,
                                                            size: 40,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        onTap: subscribed
                                            ? (quiz2 == null
                                                ? () {
                                                    scaffkey.currentState
                                                        .showSnackBar(SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    150),
                                                            content: Text(
                                                                "Quiz not Started or Quiz Finished!")));
                                                  }
                                                : () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                      return QuizTestScreen(
                                                          quiz: quiz2);
                                                    }));
                                                  })
                                            : () {
                                                scaffkey.currentState
                                                    .showSnackBar(SnackBar(
                                                        duration: Duration(
                                                            milliseconds: 180),
                                                        content: Text(
                                                            "You are not a plus member !")));
                                              }),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.lightBlue.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                height: 150,
                                                width: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/locked.png",
                                                      height: 56,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text("Quiz 3",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      height: 150,
                                                      width: 150,
                                                    )
                                                  : Container(),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      height: 150,
                                                      width: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.lock,
                                                            size: 40,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        onTap: subscribed
                                            ? (quiz3 == null
                                                ? () {
                                                    scaffkey.currentState
                                                        .showSnackBar(SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    150),
                                                            content: Text(
                                                                "Quiz not Started or Quiz Finished!")));
                                                  }
                                                : () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                      return QuizTestScreen(
                                                          quiz: quiz3);
                                                    }));
                                                  })
                                            : () {
                                                scaffkey.currentState
                                                    .showSnackBar(SnackBar(
                                                        duration: Duration(
                                                            milliseconds: 180),
                                                        content: Text(
                                                            "You are not a plus member !")));
                                              }),
                                    SizedBox(width: 12),
                                    GestureDetector(
                                        child: Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.lightBlue.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                height: 150,
                                                width: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/locked.png",
                                                      height: 56,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      "Quiz 4",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      height: 150,
                                                      width: 150,
                                                    )
                                                  : Container(),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      height: 150,
                                                      width: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.lock,
                                                            size: 40,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        onTap: subscribed
                                            ? (quiz4 == null
                                                ? () {
                                                    scaffkey.currentState
                                                        .showSnackBar(SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    150),
                                                            content: Text(
                                                                "Quiz not Started or Quiz Finished!")));
                                                  }
                                                : () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                      return QuizTestScreen(
                                                          quiz: quiz4);
                                                    }));
                                                  })
                                            : () {
                                                scaffkey.currentState
                                                    .showSnackBar(SnackBar(
                                                        duration: Duration(
                                                            milliseconds: 180),
                                                        content: Text(
                                                            "You are not a plus member !")));
                                              }),
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 12, color: Colors.white12),
                                      borderRadius: BorderRadius.circular(90),
                                      color: Colors.white,
                                    ),
                                    height: 150,
                                    width: 150,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90),
                                        color: Colors.orangeAccent,
                                      ),
                                      child: Card(
                                        color: Colors.lightBlue.shade300,
                                        margin: EdgeInsets.all(0),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/trophy.png",
                                                  height: 58,
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "Super Quiz",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            !subscribed
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white24,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    height: 150,
                                                    width: 150,
                                                  )
                                                : Container(),
                                            !subscribed
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    height: 150,
                                                    width: 150,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.lock,
                                                          size: 40,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: subscribed
                                      ? (quiz5 == null
                                          ? () {
                                              scaffkey.currentState
                                                  .showSnackBar(SnackBar(
                                                      duration: Duration(
                                                          milliseconds: 150),
                                                      content: Text(
                                                          "Quiz not Started or Quiz Finished!")));
                                            }
                                          : () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return QuizTestScreen(
                                                    quiz: quiz5);
                                              }));
                                            })
                                      : () {
                                          scaffkey.currentState.showSnackBar(
                                              SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 180),
                                                  content: Text(
                                                      "You are not a plus member !")));
                                        }),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
  }

  Widget carouselSlider(context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: UIConstants.fitToHeight(100, context),
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: cardList.map((card) {
        return Builder(builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.blueAccent,
              child: card,
            ),
          );
        });
      }).toList(),
    );
  }

  Widget carouselDots(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(cardList, (index, url) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.grey : Colors.greenAccent,
          ),
        );
      }),
    );
  }
}
