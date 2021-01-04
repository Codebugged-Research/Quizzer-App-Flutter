import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/addDataPage.dart';
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
    setState(() {
      isLoading = true;
    });
    var auth = await AuthService.getSavedAuth();
    try {
      photoUrl = auth['photoUrl'];
      print(photoUrl);
      user = await UserService.getUser();
    } catch (e) {
      print(e);
    }
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
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
      subtitle: Text(
        '$labelValue',
        style: TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            key: scaffKey,
            backgroundColor: Colors.white,
            body: Container(
              height: UIConstants.fitToHeight(640, context),
              width: UIConstants.fitToWidth(360, context),
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.shade300,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(27.0),
                          bottomRight: Radius.circular(27.0),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: UIConstants.fitToHeight(56, context)),
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoUrl),
                          backgroundColor: photoUrl == null
                              ? Colors.black
                              : Colors.white,
                          radius: 80,
                        ),
                        SizedBox(
                            height: UIConstants.fitToHeight(20, context)),
                        Text('${user.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.46)),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                              bottom:
                                  UIConstants.fitToHeight(20, context)),
                          child: InkWell(
                             onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddDataScreen()));
                          },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  profileInfo('Username', '${user.username}', Icons.person),
                  profileInfo('Phone Number', '${user.phone}', Icons.call),
                  profileInfo('Email', '${user.email}', Icons.mail),
                  profileInfo('UPI ID', '${user.upiId}', Icons.money),
                  profileInfo(
                      'Rewards', '₹ ${user.reward}', Icons.emoji_events),
                  SizedBox(height: 100,),
                ],
              ),
            ))
        : Center(child: CircularProgressIndicator());
  }
}
