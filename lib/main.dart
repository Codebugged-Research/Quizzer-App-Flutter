import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/views/splashScreen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Quiz Adda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.lightBlue.shade300,
          scaffoldBackgroundColor: Colors.white,
          primaryTextTheme:
              GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
                  bodyText1: GoogleFonts.lato(color: Colors.white),
                  bodyText2: GoogleFonts.lato(color: Colors.white),
                  headline3: GoogleFonts.lato(color: Colors.white),
                  headline4: GoogleFonts.lato(color: Colors.white),
                  headline5: GoogleFonts.lato(color: Colors.white),
                  headline6: GoogleFonts.lato(color: Colors.white),
                  subtitle1: GoogleFonts.lato(color: Colors.white),
                  subtitle2: GoogleFonts.lato(color: Colors.white),
                  button: GoogleFonts.lato(color: Colors.white),
                  caption: GoogleFonts.lato(color: Colors.white)),
          buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.0)))),
      home: SplashScreen(),
    );
  }
}
