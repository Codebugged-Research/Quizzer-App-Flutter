import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/components/planCard.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  bool isLoading = false;
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_sOzJvizxWHgZgS",
      "amount": double.parse(100.0.toString().trim()) * 100,
      "name": "Quizzer App",
      "description": "Pay to be a member",
      "prefill": {"contact": "9874948947", "email": "sayannath235@gmail.com"},
      "external": {
        "wallet": ["paytm"],
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void handlePaymentSuccess() {
    print("Payment Done");
  }

  void handlePaymentError() {
    print("Error");
  }

  void handleExternalWallet() {
    print("Yo");
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
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
                                SizedBox(
                                    height:
                                        UIConstants.fitToHeight(32, context)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 240.0),
                            child: Stack(
                              children: [
                                PlanCard(),
                                buyWidget(context),
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
          top: UIConstants.fitToHeight(170, context),
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
              //await createSubscription(context);
              openCheckOut();
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
