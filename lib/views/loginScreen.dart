import 'package:flutter/material.dart';
import 'package:quiz_app/components/backgroundPainter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> scaffkey = new GlobalKey<ScaffoldState>();
  String password = '';
  String email = '';

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
                  inputWidget((value) {
                    if (true) {
                      email = value;
                      print(email);
                    } else {
                      scaffkey.currentState.showSnackBar(new SnackBar(
                        content: new Text("Please Enter a valid Email!!"),
                      ));
                    }
                  }, (value) {
                    password = value;
                    print(password);
                  }),
                  SizedBox(height: 50),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Sign in',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5
                              .copyWith(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          onTap: () {
                            print("Email Ontap"+email);
                            print("Pass Ontap"+password);
                          },
                          splashColor: Colors.grey,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            radius: 40,
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

Widget inputWidget(emailSubmitted, passSubmitted) {
  return Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
            ),
            onSubmitted: emailSubmitted),
        SizedBox(
          height: 15,
        ),
        TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            onSubmitted: passSubmitted),
      ],
    ),
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

// showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) => AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius:
//                   BorderRadius.circular(12.0)),
//           title: Text('Please Enter the OTP'),
//           content: TextField(
//             keyboardType: TextInputType.number,
//             decoration:
//                 InputDecoration(labelText: 'OTP'),
//             onChanged: (value) {
//               otp = value;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 print(otp);
//                 Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) {
//                   return LandingScreen(
//                       selectedIndex: 0);
//                 }));
//               },
//               child: Text('Verify'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             )
//           ],
//         ));
