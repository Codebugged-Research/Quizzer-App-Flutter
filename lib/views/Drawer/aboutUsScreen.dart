import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey();

  openPrivacyPolicy() async {
    String url =
        'https://play.google.com/store/apps/details?id=nl.wikit.cvmaken&hl=en_IN&gl=US';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade300,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          height: UIConstants.fitToHeight(640, context),
          width: UIConstants.fitToWidth(360, context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Positioned(
                    child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: UIConstants.fitToHeight(24, context)),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.fill,
                              height: 140,
                            ),
                            radius: 90,
                          ),
                          SizedBox(
                              height: UIConstants.fitToHeight(32, context)),
                          Text('About Us',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.46)),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: UIConstants.fitToHeight(16, context)),
                            child: Text(
                              'Quiz Adda',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Greeting from Quiz-Adda,\n\nAs we all know the importance of GK and Current Affairs in all the competitive exams conducted by IBPS,SSC,UPSC,STATE-PCS NTPC RRB.\n\nWe also know the weightage of static gk and current affairs questions in General awareness section.SO here Quiz-Adda providing you an opportunity to get rewards for your knowledge.\n\nAt Quiz Adda you can practice quizzes on daily basis and we will give cash reward to winners. We are happy to have you here and wish you a great and bright future ahead.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              letterSpacing: 0.23,
                              fontWeight: FontWeight.w500)),
                    )),
                SizedBox(
                  height: UIConstants.fitToHeight(8, context),
                ),
                cardDetails(context, 'Privacy Policy', onTap: () async {
                  if (await canLaunch("https://quizaddaplus.tk/privacy")) {
                    await launch("https://quizaddaplus.tk/privacy");
                  } else {
                    print('Could not launch https://quizaddaplus.tk/privacy');
                  }
                }),
                SizedBox(
                  height: UIConstants.fitToHeight(8, context),
                ),
                cardDetails(context, 'Refund Policy', onTap: () async {
                  if (await canLaunch("https://quizaddaplus.tk/refund")) {
                    await launch("https://quizaddaplus.tk/refund");
                  } else {
                    print('Could not launch https://quizaddaplus.tk/refund');
                  }
                }),
                SizedBox(
                  height: UIConstants.fitToHeight(8, context),
                ),
                cardDetails(context, 'Terms & Conditions', onTap: () async{
                  if (await canLaunch("https://quizaddaplus.tk/terms")) {
                    await launch("https://quizaddaplus.tk/terms");
                  } else {
                    print('Could not launch https://quizaddaplus.tk/terms');
                  }
                }),
                SizedBox(
                  height: UIConstants.fitToHeight(16, context),
                )
              ],
            ),
          ),
        ));
  }

  Widget cardDetails(BuildContext context, String title, {VoidCallback onTap}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: UIConstants.fitToHeight(35, context),
        width: UIConstants.fitToWidth(300, context),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
                BoxShadow(
                  offset: Offset(-2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ]),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            splashColor: Colors.white,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('$title',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
