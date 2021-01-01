import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_app/models/File.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/fileService.dart';
import 'package:quiz_app/services/quizService.dart';
import 'package:quiz_app/services/responseService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Home/feedScreen.dart';
import 'package:quiz_app/views/Member/memberScreen.dart';
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
  Quiz tempQuiz1;
  Quiz tempQuiz2;
  Quiz tempQuiz3;
  Quiz tempQuiz4;
  Quiz quiz1;
  Quiz quiz2;
  Quiz quiz3;
  Quiz quiz4;
  bool subscribed = false;
  TextEditingController _numberController;
  final scaffkey = new GlobalKey<ScaffoldState>();
  List cardList = [];
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
    _numberController = TextEditingController();
    loadDataForUser();
  }

  List<Response> responses = [];

  loadDataForUser() async {
    setState(() {
      loading = true;
    });
    user = await UserService.getUser();
    responses = await ResponseService.getResponseByUserDate(user.id);
    print(responses.length);
    try {
      files = await FileService.getallcards();
      files.forEach((element) {
        cardList.add(Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Image.network(element.imageUrl, fit: BoxFit.fitWidth)));
      });
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
          tempQuiz1 = element;
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            if (responses.length > 0) {
              responses.forEach((res) {
                if (res.quiz.id == element.id) {
                  quiz1 = null;
                } else {
                  quiz1 = element;
                }
              });
            } else {
              quiz1 = element;
            }
          } else {
            quiz1 = null;
          }
        } else if (element.slot == '2') {
          tempQuiz2 = element;
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            if (responses.length > 0) {
              responses.forEach((res) {
                if (res.quiz.id == element.id) {
                  quiz2 = null;
                } else {
                  quiz2 = element;
                }
              });
            } else {
              quiz2 = element;
            }
          } else {
            quiz2 = null;
          }
        } else if (element.slot == '3') {
          tempQuiz3 = element;
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            if (responses.length > 0) {
              responses.forEach((res) {
                print(res.quiz.slot);
                if (res.quiz.id == element.id) {
                  quiz3 = null;
                } else {
                  quiz3 = element;
                }
              });
            } else {
              quiz3 = element;
            }
          } else {
            quiz3 = null;
          }
        } else if (element.slot == '4') {
          tempQuiz4 = element;
          if (now.isAfter(tempStartDateTime) &&
              now.isBefore(tempEndtDateTime)) {
            if (responses.length > 0) {
              responses.forEach((res) {
                print(res.quiz.slot);
                if (res.quiz.id == element.id) {
                  quiz4 = null;
                } else {
                  quiz4 = element;
                }
              });
            } else {
              quiz4 = element;
            }
          } else {
            quiz4 = null;
          }
        } else {}
      });
    });
    setState(() {
      loading = false;
    });
    user.phone == null ? addPhoneNumber() : print("Hi!");
  }
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
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
                      padding: const EdgeInsets.only(top: 4.0),
                      child: carouselSlider(context),
                    ),
                    carouselDots(context),
                    Container(
                        height: UIConstants.fitToHeight(screenHeight*0.55, context),
                        width: UIConstants.fitToWidth(screenHeight*0.55, context),
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
                                          height: screenHeight*0.23,
                                          width: screenHeight*0.23,
                                          child: Padding(
                                            padding: const EdgeInsets.all(32.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/unlocked.png",
                                                  height: 32,
                                                ),
                                                SizedBox(
                                                    height:
                                                        UIConstants.fitToHeight(
                                                            6, context)),
                                                Text(
                                                  tempQuiz1 == null
                                                      ? "No"
                                                      : tempQuiz1.name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // SizedBox(
                                                //     height:
                                                //         UIConstants.fitToHeight(
                                                //             2, context)),
                                                Text(
                                                  tempQuiz1 == null
                                                      ? "Quiz"
                                                      : tempQuiz1.startTime +
                                                          "\n" +
                                                          tempQuiz1.endTime,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: quiz1 == null
                                          ? () {
                                              showDialog(
                                                  context: (context),
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        title: Text("Alert"),
                                                        content: Text(
                                                            "Quiz not Started or Quiz Finished!"),
                                                      ));
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
                                    SizedBox(
                                        width: UIConstants.fitToHeight(
                                            8, context)),
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
                                                height: screenHeight*0.23,
                                                width: screenHeight*0.23,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/locked.png",
                                                      height: 32,
                                                    ),
                                                    SizedBox(
                                                        height: UIConstants
                                                            .fitToHeight(
                                                                6, context)),
                                                    Text(
                                                      tempQuiz2 == null
                                                          ? "No"
                                                          : tempQuiz2.name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // SizedBox(
                                                    //     height: UIConstants
                                                    //         .fitToHeight(
                                                    //             2, context)),
                                                    Text(
                                                      tempQuiz2 == null
                                                          ? "Quiz"
                                                          : tempQuiz2
                                                                  .startTime +
                                                              "\n" +
                                                              tempQuiz2.endTime,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                height: screenHeight*0.23,
                                                width: screenHeight*0.23,
                                                    )
                                                  : Container(),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                height: screenHeight*0.23,
                                                width: screenHeight*0.23,
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
                                                    showDialog(
                                                        context: (context),
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                  title: Text(
                                                                      "Alert"),
                                                                  content: Text(
                                                                      "Quiz not Started or Quiz Finished!"),
                                                                ));
                                                  }
                                                : () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                            context) {
                                                          return QuizTestScreen(
                                                              quiz: quiz2);
                                                        },
                                                      ),
                                                    );
                                                  })
                                            : () {
                                                showDialog(
                                                  context: (context),
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    title: Text("Alert"),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            "You are not a Plus Member"),
                                                        MaterialButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MemberScreen()));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        2),
                                                            child: Text(
                                                                "Subscribe",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          color: Colors
                                                              .lightBlue
                                                              .shade300,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        UIConstants.fitToHeight(8, context)),
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
                                              color: Colors.lightBlue.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            height: screenHeight*0.23,
                                            width: screenHeight*0.23,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/timeline.png",
                                                  height: 32,
                                                ),
                                                SizedBox(
                                                    height:
                                                        UIConstants.fitToHeight(
                                                            6, context)),
                                                Text("Feed",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return FeedScreen();
                                              },
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                        width: UIConstants.fitToHeight(
                                            8, context)),
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
                                                height: screenHeight*0.23,
                                                width: screenHeight*0.23,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/locked.png",
                                                      height: 32,
                                                    ),
                                                    SizedBox(
                                                        height: UIConstants
                                                            .fitToHeight(
                                                                6, context)),
                                                    Text(
                                                      tempQuiz3 == null
                                                          ? "No"
                                                          : tempQuiz3.name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // SizedBox(
                                                    //     height: UIConstants
                                                    //         .fitToHeight(
                                                    //             2, context)),
                                                    Text(
                                                      tempQuiz3 == null
                                                          ? "Quiz"
                                                          : tempQuiz3
                                                                  .startTime +
                                                              "\n" +
                                                              tempQuiz3.endTime,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                height: screenHeight*0.23,
                                                width: screenHeight*0.23,
                                                    )
                                                  : Container(),
                                              !subscribed
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                height: screenHeight*0.23,
                                                width: screenHeight*0.23,
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
                                                    showDialog(
                                                        context: (context),
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                  title: Text(
                                                                      "Alert"),
                                                                  content: Text(
                                                                      "Quiz not Started or Quiz Finished!"),
                                                                ));
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
                                                showDialog(
                                                    context: (context),
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              title:
                                                                  Text("Alert"),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                      "You are not a Plus Member"),
                                                                  MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pushReplacement(
                                                                              MaterialPageRoute(builder: (context) => MemberScreen()));
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0,
                                                                          vertical:
                                                                              2),
                                                                      child: Text(
                                                                          "Subscribe",
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                    ),
                                                                    color: Colors
                                                                        .lightBlue
                                                                        .shade300,
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                                              }),
                                  ],
                                ),
                              ],
                            ),
                            superquiz(context),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
  }

  Widget superquiz(context) {
    return Center(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.white12),
            borderRadius: BorderRadius.circular(90),
            color: Colors.white,
          ),
          height: screenHeight*0.21,
          width: screenHeight*0.21,
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
                borderRadius: BorderRadius.circular(90),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/trophy.png",
                        height: 32,
                      ),
                      SizedBox(height: UIConstants.fitToHeight(4, context)),
                      Text(
                        tempQuiz4 == null ? "No Super" : "Super Quiz",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        tempQuiz4 == null
                            ? "Quiz"
                            : tempQuiz4.startTime + "\n" + tempQuiz4.endTime,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: (quiz4 == null
            ? () {
                showDialog(
                    context: (context),
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: Text("Alert"),
                          content: Text("Quiz not Started or Quiz Finished!"),
                        ));
              }
            : () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return QuizTestScreen(quiz: quiz4);
                }));
              }),
      ),
    );
  }

  Widget carouselSlider(context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: UIConstants.fitToHeight((screenHeight*0.18), context),
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
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
          return InkWell(
            onTap: () {
              showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    child: PinchZoomImage(
                      image: card,
                      zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                      hideStatusBarWhileZooming: true,
                      onZoomStart: () {
                        // print('Zoom started');
                      },
                      onZoomEnd: () {
                        // print('Zoom finished');
                      },
                    ),
                  ),
                ),
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: card,
              ),
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
            color: _currentIndex != index ? Colors.grey : Colors.greenAccent,
          ),
        );
      }),
    );
  }

  addPhoneNumber() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            // ignore: missing_return
            onWillPop: () {},
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text('Add your Phone Number!!!',
                  style: GoogleFonts.sourceSansPro(
                      textStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: UIConstants.fitToHeight(20, context)),
                      TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val.length == null) {
                            return "Phone Number cannot be Empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: new InputDecoration(
                          labelText: "Enter your Number!",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 14),
                          prefix: Text('+91 '),
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Color(0xff000000),
                  onPressed: () async {
                    if (_numberController.text.length != 10 ||
                        _numberController.text == "" ||
                        _numberController.text == " ") {
                      scaffkey.currentState.showSnackBar(SnackBar(
                        content: Text("Please fill your Number."),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      await updatePhoneNumber();
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )));
  }

  updatePhoneNumber() async {
    var payload = json.encode({"phone": _numberController.text});
    try {
      bool updated = await UserService.updateUser(payload);
      if (updated) {
        Navigator.of(context).pop();
        scaffkey.currentState.showSnackBar(new SnackBar(
          content: new Text("Phone Number added!!!"),
        ));
      } else {
        scaffkey.currentState.showSnackBar(new SnackBar(
          content:
              new Text("Failed to add Phone Number. Please try again later!!!"),
        ));
      }
    } catch (e) {
      scaffkey.currentState.showSnackBar(new SnackBar(
        content: new Text("Something went Wrong. Please try again later!!!"),
      ));
      print(e);
    }
  }
}
