import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/quizService.dart';
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
  List<Quiz> quizes = [];
  List<Quiz> quiz1 = [];
  List<Quiz> quiz2 = [];
  List<Quiz> quiz3 = [];
  List<Quiz> quiz4 = [];
  List<Quiz> quiz5 = [];
  List cardList = [Item1(), Item2(), Item3(), Item4()];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    loadDataForUser();
  }

  loadDataForUser() async {
    var auth = await AuthService.getSavedAuth();
    setState(() {
      name = auth['name'];
      email = auth['email'];
    });
    quizes = await QuizService.getAllQuiz();
    setState(() {
      quiz1 = quizes.where((element) {
        if (element.slot == '1')
          return true;
        else
          return false;
      }).toList();
      quiz2 = quizes.where((element) {
        if (element.slot == '2')
          return true;
        else
          return false;
      }).toList();
      quiz3 = quizes.where((element) {
        if (element.slot == '3')
          return true;
        else
          return false;
      }).toList();
      quiz4 = quizes.where((element) {
        if (element.slot == '4')
          return true;
        else
          return false;
      }).toList();
      quiz5 = quizes.where((element) {
        if (element.slot == '5')
          return true;
        else
          return false;
      }).toList();
    });
    print(quizes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return QuizTestScreen(quiz: quiz1);
                                  }));
                                },
                              ),
                              SizedBox(width: 12),
                              GestureDetector(
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade300,
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
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 150,
                                        width: 150,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              size: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return QuizTestScreen(quiz: quiz2);
                                  }));
                                },
                              ),
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade300,
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
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 150,
                                        width: 150,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              size: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return QuizTestScreen(quiz: quiz3);
                                  }));
                                },
                              ),
                              SizedBox(width: 12),
                              GestureDetector(
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade300,
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 150,
                                        width: 150,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.lock,
                                              size: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return QuizTestScreen(quiz: quiz4);
                                  }));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 12, color: Colors.white12),
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
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return QuizTestScreen(quiz: quiz5);
                            }));
                          },
                        ),
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
