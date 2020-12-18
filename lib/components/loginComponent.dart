import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/views/addDataPage.dart';
import 'package:quiz_app/views/landingScreen.dart';

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
    return SizedBox(
      height: UIConstants.fitToHeight(40, context),
      width: UIConstants.fitToWidth(240, context),
      child: RaisedButton(
        color: Colors.white,
        onPressed: () async {
          final GoogleSignInAccount googleUser = await googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          if (googleAuth.accessToken != null) {
            bool authenticated = await AuthService.authenticate(
                googleUser.displayName,
                googleUser.email,
                googleUser.id,
                googleUser.photoUrl.toString());
            if (authenticated) {
              print(authenticated);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return AddDataScreen();
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
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assets),
            SizedBox(
              width: UIConstants.fitToWidth(8, context),
            ),
            Text(
              '$title',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.black,
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
