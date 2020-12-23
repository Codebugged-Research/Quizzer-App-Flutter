import 'package:flutter/material.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/views/Drawer/aboutUsScreen.dart';
import 'package:quiz_app/views/Drawer/contactScreen.dart';
import 'package:quiz_app/views/landingScreen.dart';
import 'package:quiz_app/views/loginScreen.dart';
import 'dart:io' show Platform;

import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerComponent extends StatelessWidget {
  final String name;
  final String email;
  final String photUrl;
  final String username;
  DrawerComponent({this.name, this.email, this.photUrl,this.username});

  signOut(context) async {
    await AuthService.clearAuth();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return LogInScreen();
    }));
  }

  rateApp() async {
    String url =
        'https://play.google.com/store/apps/details?id=nl.wikit.cvmaken&hl=en_IN&gl=US';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  shareApp() async {
    String url =
        'https://play.google.com/store/apps/details?id=nl.wikit.cvmaken&hl=en_IN&gl=US';
    if (Platform.isAndroid) {
      await ShareExtend.share('Check out this Amazing Quiz App $url', "text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffFFFFFF),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade300,
              ),
              accountName: Text('$username',
                 style: Theme.of(context)
                     .primaryTextTheme
                     .subtitle1
                     .copyWith(color: Colors.black)),
              accountEmail: Text('$email',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle2
                      .copyWith(color: Colors.black)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(photUrl),
                child: photUrl == null ? Text(
                  "${name.split(" ").first.split("").first}",
                  style: TextStyle(fontSize: 40.0, color: Colors.black),
                ):Container(),
              ),
            ),
            ListTile(
              title: Text(
                "Home",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.home, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LandingScreen(selectedIndex: 0);
                }));
              },
            ),
            ListTile(
              title: Text(
                "About Us",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.info, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AboutUsScreen();
                }));
              },
            ),
            ListTile(
              title: Text(
                "Contact Us",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.contact_mail, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ContactScreen();
                }));
              },
            ),
            ListTile(
              title: Text(
                "Refer",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.share, color: Colors.black),
              onTap: () async {
                await shareApp();
              },
            ),
            ListTile(
              title: Text(
                "Rate Us",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.star, color: Colors.black),
              onTap: () async {
                rateApp();
              },
            ),
            Divider(
              color: Color(0xff707070),
              thickness: 1.0,
            ),
            ListTile(
              title: Text(
                "Sign Out",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1
                    .copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.exit_to_app, color: Colors.black),
              onTap: () {
                signOut(context);
              },
            ),
          ],
        ));
  }
}
