import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/pushService.dart';
import 'package:quiz_app/views/startingScreen.dart';

class LoginButtonComponentAndroid extends StatelessWidget {
  final googleSignIn = GoogleSignIn();
  final GlobalKey scaffkey;
  LoginButtonComponentAndroid({this.scaffkey});

  @override
  Widget build(BuildContext context) {
    return loginButton(
        'Sign in with Google', 'assets/images/google.png', context);
  }

  Widget loginButton(String title, String assets, BuildContext context) {
    return Container(
      height: UIConstants.fitToHeight(40, context),
      width: UIConstants.fitToWidth(240, context),
      child: MaterialButton(
        elevation: 0,
        color: Color(0xffdd4b39),
        onPressed: () async {
          final GoogleSignInAccount googleUser = await googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          if (googleAuth.accessToken != null) {
            print(googleUser.photoUrl.toString());
            bool authenticated = await AuthService.authenticate(
                googleUser.displayName,
                googleUser.email,
                googleUser.id,
                googleUser.photoUrl.toString());
            if (authenticated) {
              print(authenticated);
              await PushService.genTokenID();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return StartingScreen();
              }));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Authentication Failure!!!'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'))
                      ],
                    );
                  });
            }
          }else{
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Authentication Failure!!!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'))
                    ],
                  );
                });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assets,height: 24,),
            SizedBox(
              width: UIConstants.fitToWidth(8, context),
            ),
            Text(
              '$title',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
