import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String photoUrl = '';
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey();
  User user;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadDataForScreen();
  }

  loadDataForScreen() async {
    var auth = await AuthService.getSavedAuth();
    setState(() {
      isLoading = true;
    });
    try {
      photoUrl = auth['photoUrl'];
      user = await UserService.getUser();
    } catch (e) {
      print(e);
    }

    print(photoUrl);
    setState(() {
      isLoading = false;
    });
  }

  signOut(context) async {
    await AuthService.clearAuth();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return LogInScreen();
    }));
  }

  Widget profileInfo(String labelText, String labelValue, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text('$labelText',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 17,
              fontWeight: FontWeight.bold)),
      subtitle: Text(
        '$labelValue',
        style: TextStyle(
            fontFamily: 'Montserrat', fontSize: 15, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffKey,
        backgroundColor: Colors.white,
        body: !isLoading
            ? Container(
                height: UIConstants.fitToHeight(640, context),
                width: UIConstants.fitToWidth(360, context),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(children: [
                        Positioned(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue.shade300,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(27.0),
                                  bottomRight: Radius.circular(27.0),
                                  topRight: Radius.circular(0.0),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        UIConstants.fitToHeight(56, context)),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(photoUrl),
                                  backgroundColor: photoUrl == null
                                      ? Colors.black
                                      : Colors.white,
                                  radius: 80,
                                  child: photoUrl == null
                                      ? Text(
                                          'SN',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32),
                                        )
                                      : null,
                                ),
                                SizedBox(
                                    height:
                                        UIConstants.fitToHeight(20, context)),
                                Text('${user.name}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.46)),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          UIConstants.fitToHeight(20, context)),
                                  child: Text(
                                    'User',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                      profileInfo('Phone Number', '+91 9874948947', Icons.call),
                      profileInfo('Email', '${user.email}', Icons.mail),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
