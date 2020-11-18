import 'package:flutter/material.dart';
import 'package:quiz_app/views/landingScreen.dart';

class DrawerComponent extends StatelessWidget {
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
              accountName: Text('Sayan Nath',
                  style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black)),
              accountEmail: Text('sayannath235@gmail.com',
                  style: Theme.of(context).primaryTextTheme.subtitle2.copyWith(color: Colors.black)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "S",
                  style: TextStyle(fontSize: 40.0, color: Colors.black),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Home",
                style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black),
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
                style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.info, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LandingScreen(selectedIndex: 0);
                }));
              },
            ),
            ListTile(
              title: Text(
                "Contact Us",
                style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.contact_mail, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LandingScreen(selectedIndex: 0);
                }));
              },
            ),
            ListTile(
              title: Text(
                "Refer",
                style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.share, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LandingScreen(selectedIndex: 0);
                }));
              },
            ),
            ListTile(
              title: Text(
                "Rate Us",
                style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.star, color: Colors.black),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LandingScreen(selectedIndex: 0);
                }));
              },
            ),
            Divider(
              color: Color(0xff707070),
              thickness: 1.0,
            ),
            ListTile(
              title: Text(
                "Sign Out",
                style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(color: Colors.black),
              ),
              trailing: Icon(Icons.exit_to_app, color: Colors.black),
              onTap: () {},
            ),
          ],
        ));
  }
}
