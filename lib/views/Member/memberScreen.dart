import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/components/planCard.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/razorPayService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Member/payemntscrenn.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  bool isLoading = false;
  User user;
  String orderId;
  var options;

  @override
  void initState() {
    super.initState();
    loadDataForScreen();
  }

  bool subscribed = false;
  loadDataForScreen() async {
    user = await UserService.getUser();
    if (user.subscription.validTill.difference(DateTime.now()).inDays >= 0) {
      setState(() {
        subscribed = true;
      });
    }
  }

  final scaffkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        key: scaffkey,
        body: !isLoading
            ? CustomPaint(
                painter: CurvePainter(),
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: UIConstants.fitToHeight(320, context),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        UIConstants.fitToHeight(75, context)),
                                Text(
                                  'Subscription',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline4
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Stack(
                              children: [
                                PlanCard(),
                                subscribed ? Container() : buyWidget(context),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget buyWidget(context) {
    return Positioned(
      top: UIConstants.fitToHeight(160, context),
      left: UIConstants.fitToWidth(55, context),
      right: UIConstants.fitToWidth(55, context),
      child: Container(
          height: UIConstants.fitToHeight(40, context),
          width: UIConstants.fitToWidth(110, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ]),
          child: MaterialButton(
            onPressed: () async {
              orderId = await RazorPayService.createOrderId(
                  jsonEncode({"amount": 10000}));
              print(orderId);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RazorPayScreen()));
            },
            color: Colors.white,
            child: Text(
              'Subscribe!',
              style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(color: Colors.black),
            ),
          )),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.lightBlue.shade300;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
