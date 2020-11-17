import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/views/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Quizzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF3B9EC5),
          scaffoldBackgroundColor: Colors.white,
          primaryTextTheme:
              GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
                  headline3: GoogleFonts.lato(color: Colors.white),
                  headline4: GoogleFonts.lato(color: Colors.white),
                  headline5: GoogleFonts.lato(color: Colors.white),
                  headline6: GoogleFonts.lato(color: Colors.white),
                  subtitle1: GoogleFonts.lato(color: Colors.white),
                  subtitle2: GoogleFonts.lato(color: Colors.white),
                  button: GoogleFonts.lato(color: Colors.white),
                  caption: GoogleFonts.lato(color: Colors.white)),
          buttonTheme: ButtonThemeData(
              buttonColor: Color(0xffF40555),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffF40555)),
                  borderRadius: BorderRadius.circular(25.0)))),
      home: SplashScreen(),
    );
  }
}
