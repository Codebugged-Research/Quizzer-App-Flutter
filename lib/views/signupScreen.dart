import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/components/backgroundPainter.dart';
import 'package:quiz_app/views/landingScreen.dart';
import 'package:quiz_app/views/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  final formkey = new GlobalKey<FormState>();
  bool isLoading = false;
  String name = '';
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

  auth() async {
    setState(() {
      isLoading = true;
    });
    if (checkFields()) {
      var payload =
          json.encode({"name": name, "email": email, "password": password});
      print(payload);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LandingScreen(selectedIndex: 0);
      }));
    } else {
      scaffkey.currentState.showSnackBar(new SnackBar(
        content: new Text("Authentication faliure !! Please retry."),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      body: CustomPaint(
        painter: BackgroundSignIn(),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  getHeader(context),
                  SizedBox(height: 50),
                  Expanded(
                    flex: 4,
                    child: Form(
                      key: formkey,
                      child: SingleChildScrollView(
                                              child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 120,
                            ),
                            inputWidget(
                                'Please Enter the Name',
                                TextInputType.name,
                                Icons.person,
                                false,
                                'Name',
                                'Name',
                                (value) => name = value),
                            SizedBox(
                              height: 15,
                            ),
                            inputWidget(
                                'Please Enter the Email Address',
                                TextInputType.emailAddress,
                                Icons.email,
                                false,
                                'Email',
                                'Email Address',
                                (value) => email = value),
                            SizedBox(
                              height: 15,
                            ),
                            inputWidget(
                                'Please Enter the Password',
                                TextInputType.text,
                                Icons.lock,
                                true,
                                'Password',
                                'Password',
                                (value) => password = value),
                            SizedBox(height: 14),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return LogInScreen();
                                }));
                              },
                              child: Text(
                                'Already have an account? Log in',
                                style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black))
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Sign up',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5
                              .copyWith(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          onTap: () {
                            auth();
                          },
                          splashColor: Colors.grey,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            radius: 30,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  //_getBottomRow(context),
                ],
              ),
            ),
            // _getBackBtn(),
          ],
        ),
      ),
    );
  }
}

Widget inputWidget(String validation, TextInputType type, IconData icon, bool,
    String label, String hint, save) {
  return new TextFormField(
    keyboardType: type,
    decoration: InputDecoration(
        hintText: hint, labelText: label, prefixIcon: Icon(icon)),
    obscureText: bool,
    validator: (value) => value.isEmpty ? validation : null,
    onSaved: save,
  );
}

Widget getHeader(context) {
  return Expanded(
    flex: 3,
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Welcome!',
        style:
            Theme.of(context).primaryTextTheme.headline3.copyWith(fontSize: 40),
      ),
    ),
  );
}
