import 'package:flutter/material.dart';
import 'package:quiz_app/components/backgroundPainter.dart';
import 'package:quiz_app/views/landingScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> scaffkey = new GlobalKey<ScaffoldState>();
  String phone = '';
  String otp = '';

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
                  getTextFields((value) {
                    if (value.length == 10) {
                      phone = value;
                    } else {
                      scaffkey.currentState.showSnackBar(new SnackBar(
                        content:
                            new Text("Please Enter a valid Phone Number!!"),
                      ));
                    }
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
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      title: Text('Please Enter the OTP'),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            InputDecoration(labelText: 'OTP'),
                                        onChanged: (value) {
                                          otp = value;
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            print(otp);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return LandingScreen(
                                                  selectedIndex: 0);
                                            }));
                                          },
                                          child: Text('Verify'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        )
                                      ],
                                    ));
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

Widget getTextFields(submitted) {
  return Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        TextField(
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              prefixText: '+91 ',
              labelText: 'Mobile No.',
            ),
            onSubmitted: submitted),
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
