import 'package:flutter/material.dart';
import 'package:quiz_app/components/drawerComponent.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_app/views/Home/Carousel/itemFour.dart';
import 'package:quiz_app/views/Home/Carousel/itemOne.dart';
import 'package:quiz_app/views/Home/Carousel/itemThree.dart';
import 'package:quiz_app/views/Home/Carousel/itemTwo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List cardList = [Item1(), Item2(), Item3(), Item4()];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 300,
                width: 300,
                color: Colors.black,
              ),
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
            color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
          ),
        );
      }),
    );
  }
}
