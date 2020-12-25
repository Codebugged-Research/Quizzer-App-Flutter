import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/landingScreen.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController upi = TextEditingController();
  bool loading = false;
  User user;
  @override
  void initState() {
    super.initState();
    loadDataForScreen();
  }

  loadDataForScreen() async {
    setState(() {
      loading = true;
    });
    user = await UserService.getUser();
    setState(() {
      username.text = user.username;
      upi.text = user.upiId;
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context)
              .primaryTextTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.46),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SizedBox(
                      width: UIConstants.fitToWidth(280, context),
                      child: TextFormField(
                        controller: username,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter New Username",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          prefixIcon: Icon(Icons.person),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) =>
                            value.isEmpty ? "enter valid username" : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SizedBox(
                      width: UIConstants.fitToWidth(280, context),
                      child: TextFormField(
                        controller: upi,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter New UPI ID",
                          hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          prefixIcon: Icon(Icons.code),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        validator: (value) =>
                            value.contains("@") ? "enter valid upiId" : null,
                      ),
                    ),
                  ),
                  MaterialButton(
                    height: 55,
                    minWidth: 200,
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Update", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                    onPressed: () async {
                      bool done = await UserService.updateUser(jsonEncode(
                          {"username": username.text, "upiId": upi.text}));
                      if (done) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LandingScreen(
                                  selectedIndex: 0,
                                )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text("User Update Failed."),
                                ));
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
