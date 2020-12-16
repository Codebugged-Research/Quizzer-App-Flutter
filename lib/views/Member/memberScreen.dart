import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/components/planCard.dart';
import 'package:quiz_app/constants/ui_constants.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  bool isLoading = false;

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
                          // image: DecorationImage(
                          //   image:
                          //       AssetImage('assets/images/plan/background.jpg'),
                          //   fit: BoxFit.cover,
                          //   colorFilter: ColorFilter.mode(
                          //       Colors.black.withOpacity(0.55),
                          //       BlendMode.darken),
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: UIConstants.fitToHeight(75, context)),
                                Text(
                                  'Subscription',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline4
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                    height: UIConstants.fitToHeight(32, context)),
                                // Align(
                                //     alignment: Alignment.center,
                                //     child: Text('Plan',
                                //         style: GoogleFonts.sourceSansPro(
                                //             textStyle: TextStyle(
                                //                 color: Colors.white,
                                //                 fontSize: 24,
                                //                 letterSpacing: 0.36,
                                //                 fontWeight: FontWeight.w700)))),
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
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return PlanCard();
                              }),
                        ),
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
