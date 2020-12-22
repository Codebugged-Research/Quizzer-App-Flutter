import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // @override
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey();

  void launchMail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'sayannath235@gmail.com',
        query: 'subject=Quiz Adda App Feedback&body=Hello!');
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
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
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            radius: 100,
                          ),
                          SizedBox(
                              height: UIConstants.fitToHeight(32, context)),
                          Text('Contact Us',
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
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              letterSpacing: 0.23,
                              fontWeight: FontWeight.w500)),
                    )),
                cardDetails(context, 'Email', Icons.mail, onTap: () {
                  launchMail();
                }),
                SizedBox(height: 16),
                cardDetails(context, 'Phone', Icons.call, onTap: () {
                  launch(('tel://09874948100'));
                }),
              ],
            ),
          ),
        ));
  }

  Widget cardDetails(BuildContext context, String title, IconData iconData,
      {VoidCallback onTap}) {
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
                  Icon(iconData)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
