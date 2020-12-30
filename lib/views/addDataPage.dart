import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/landingScreen.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final GlobalKey<ScaffoldState> scaffkey = new GlobalKey<ScaffoldState>();
  final formkey = new GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _upi = TextEditingController();
  List<String> exams = [];
  List<String> interests = [];
  List<DropdownMenuItem> examsList = [
    DropdownMenuItem(
      child: Text("JEE"),
      value: "JEE",
    ),
  ];
  List<DropdownMenuItem> interestsList = [
    DropdownMenuItem(
      child: Text("Current Affairs"),
      value: "Current Affairs",
    ),
  ];

  bool isLoading = false;
  User user;

  @override
  void initState() {
    super.initState();
    loadDataForScreen();
  }

  loadDataForScreen() async {
    setState(() {
      isLoading = true;
    });
    user = await UserService.getUser();
    String username = user.email.split("@")[0].toString();
    _username.text = username;
    setState(() {
      isLoading = false;
    });
  }

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

  updateData() async {
    setState(() {
      isLoading = true;
    });
    if (checkFields()) {
      var payload = json.encode({
        "username": _username.text,
        "phone": _phone.text,
        "upiId": _upi.text,
        "exams": exams,
        "interests": interests,
        // "contactId": contactId,
        // "fundAccount": fundId
      });
      print(payload);
      bool updated = await UserService.updateUser(payload);
      print(updated);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LandingScreen(selectedIndex: 0);
      }));
    } else {
      scaffkey.currentState.showSnackBar(new SnackBar(
        content: new Text("fill all the fields!!!"),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget _dropDown(List<DropdownMenuItem> source, List target, String hint) {
    return Padding(
      padding: EdgeInsets.only(
        left: UIConstants.fitToWidth(40, context),
        right: UIConstants.fitToWidth(40, context),
      ),
      child: FormField(
        builder: (FormFieldState state) {
          return DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            isDense: true,
            items: source,
            icon: Icon(Icons.category),
            onChanged: (value) {
              setState(() {
                target.add(value);
              });
            },
          );
        },
      ),
    );
  }

  Widget _input(TextEditingController _text, int textWidth, String validation,
      bool, String label, String hint, IconData icon, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: UIConstants.fitToWidth(textWidth, context),
        child: TextFormField(
          controller: _text,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: type,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          obscureText: bool,
          validator: (value) => value.isEmpty ? validation : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      body: CustomPaint(
        painter: CurvePainter(),
        child: Container(
          height: UIConstants.fitToHeight(640, context),
          width: UIConstants.fitToWidth(360, context),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: UIConstants.fitToHeight(23, context),
                        bottom: UIConstants.fitToHeight(20, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: UIConstants.fitToHeight(100, context)),
                        Text(
                          'Add your data',
                          style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                  color: Color(0xff0000000),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                        ),
                        SizedBox(width: UIConstants.fitToWidth(8, context)),
                        Image.asset(
                          'assets/images/data.png',
                          height: UIConstants.fitToHeight(30, context),
                          width: UIConstants.fitToWidth(30, context),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: UIConstants.fitToHeight(48, context)),
                  Form(
                      key: formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _input(
                                _username,
                                280,
                                'Please fill the Username',
                                false,
                                'Username',
                                'Username',
                                Icons.person,
                                TextInputType.name),
                            _input(
                                _phone,
                                280,
                                'Please fill the Phone Number',
                                false,
                                'Phone Number',
                                'Phone Number',
                                Icons.call,
                                TextInputType.phone),
                            _input(
                                _upi,
                                280,
                                'Please fill the UPI ID',
                                false,
                                'UPI ID',
                                'UPI ID',
                                Icons.money,
                                TextInputType.name),
                            _dropDown(examsList, exams, "Choose Your Exam"),
                            SizedBox(height:16),
                            _dropDown(interestsList, interests,
                                "Choose Your Interests"),
                          ],
                        ),
                      )),
                  SizedBox(height: UIConstants.fitToHeight(32, context)),
                  !isLoading
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: UIConstants.fitToWidth(34, context),
                              right: UIConstants.fitToWidth(34, context),
                              bottom: UIConstants.fitToHeight(20, context)),
                          child: SizedBox(
                            height: UIConstants.fitToHeight(40, context),
                            width: UIConstants.fitToWidth(292, context),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                color: Color(0xff25354E),
                                elevation: 2.0,
                                onPressed: () async {
                                  await updateData();
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          ),
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0xff25354E))),
                        ))
                ]),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff25354E);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
