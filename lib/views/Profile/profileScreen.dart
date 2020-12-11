import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String photoUrl = '';
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
        body: !_isLoading
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
                            //height: UIConstants.fitToHeight(380, context), // Change
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
                                        UIConstants.fitToHeight(55, context)),
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 86.5,
                                  child: Text(
                                    'SN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                // SizedBox(
                                //     height:
                                //         UIConstants.fitToHeight(10, context)),
                                // InkWell(
                                //   splashColor: Colors.white,
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //         MaterialPageRoute(
                                //             builder: (BuildContext context) {
                                //       return EditProfileScreen(
                                //           user: user, photoUrl: photoUrl);
                                //     }));
                                //   },
                                //   child: Text('Edit Profile',
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.w400,
                                //           letterSpacing: 0.24)),
                                // ),
                                SizedBox(
                                    height:
                                        UIConstants.fitToHeight(20, context)),
                                Text('Sayan Nath',
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
                      profileInfo(
                          'Email', 'sayannath2352gmail.com', Icons.mail),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
