import 'package:flutter/material.dart';
import 'package:quiz_app/components/backgroundPainter.dart';
import 'package:quiz_app/components/loginComponent.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String email = '';
  final formkey = new GlobalKey<FormState>();
  bool isLoading = false;
  String password = '';
  final GlobalKey<ScaffoldState> scaffkey = new GlobalKey<ScaffoldState>();

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      isLoading = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffkey,
      body: CustomPaint(
        painter: BackgroundSignIn(),
        child: SingleChildScrollView(
          child: Container(
            height: UIConstants.fitToHeight(640, context),
            width: UIConstants.fitToWidth(360, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome!',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          .copyWith(fontSize: 40),
                    ),
                  ),
                ),
                SizedBox(
                  height: UIConstants.fitToHeight(75, context),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: UIConstants.fitToHeight(180, context),
                ),
                SizedBox(
                  height: UIConstants.fitToHeight(30, context),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: LoginButtonComponentAndroid(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Text("Privacy Policy"),
                            onTap: () async {
                              if (await canLaunch(
                                  "https://quizaddaplus.tk/privacy")) {
                                await launch("https://quizaddaplus.tk/privacy");
                              } else {
                                print(
                                    'Could not launch https://quizaddaplus.tk/privacy');
                              }
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Text("Refund Policy"),
                            onTap: () async {
                              if (await canLaunch(
                                  "https://quizaddaplus.tk/refund")) {
                                await launch("https://quizaddaplus.tk/refund");
                              } else {
                                print(
                                    'Could not launch https://quizaddaplus.tk/refund');
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        child: Text("Terms & Condition"),
                        onTap: () async {
                          if (await canLaunch(
                              "https://quizaddaplus.tk/terms")) {
                            await launch("https://quizaddaplus.tk/terms");
                          } else {
                            print(
                                'Could not launch https://quizaddaplus.tk/terms');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
