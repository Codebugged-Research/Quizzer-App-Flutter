import 'package:flutter/material.dart';
import 'package:quiz_app/components/drawerComponent.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/History/quizHistory.dart';
import 'package:quiz_app/views/Home/homeScreen.dart';
import 'package:quiz_app/views/Member/memberScreen.dart';
import 'package:quiz_app/views/Profile/profileScreen.dart';
import 'package:quiz_app/views/Quiz/quizScreen.dart';

class LandingScreen extends StatefulWidget {
  final int selectedIndex;
  LandingScreen({this.selectedIndex});
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  bool isLoading = false;
  Color _selectedColor = Colors.orangeAccent;
  User user;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    // loadDataForScreen();
    loadDataForUser();
  }

  loadDataForUser() async {
    setState(() {
      isLoading = true;
    });
    user = await UserService.getUser();
    setState(() {
      isLoading = false;
    });
  }

  // ignore: unused_element
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    QuizScreen(),
    QuizHistory(),
    ProfileScreen()
  ];

  List names = [
    'Quiz Adda',
    'Quiz Adda',
    'Previous Quizes',
    'Quiz Adda',
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            extendBody: true,
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              centerTitle: true,
              title: Text(
                names[_selectedIndex],
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.46),
              ),
            ),
            drawer: Drawer(
              child: DrawerComponent(
                  name: user.name, email: user.email, photUrl: user.photoUrl),
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FloatingActionButton(
                  tooltip: 'Be the Member',
                  backgroundColor: Colors.lightBlue.shade300,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MemberScreen();
                    }));
                  },
                  child: Icon(
                    Icons.military_tech,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                shape: CircularNotchedRectangle(),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                            _selectedColor = Colors.orangeAccent;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home,
                                  color: _selectedIndex == 0
                                      ? _selectedColor
                                      : Color(0xff80879A)),
                              Text('Home',
                                  style: TextStyle(
                                      color: _selectedIndex == 0
                                          ? _selectedColor
                                          : Color(0xff80879A)))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                            _selectedColor = Colors.orangeAccent;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 12.0, bottom: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.dynamic_form,
                                  color: _selectedIndex == 1
                                      ? _selectedColor
                                      : Color(0xff80879A)),
                              Text(
                                'Quiz',
                                style: TextStyle(
                                    color: _selectedIndex == 1
                                        ? _selectedColor
                                        : Color(0xff80879A)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 12.0, bottom: 8.0),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                            _selectedColor = Colors.orangeAccent;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 12.0, bottom: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history,
                                  color: _selectedIndex == 2
                                      ? _selectedColor
                                      : Color(0xff80879A)),
                              Text(
                                'History',
                                style: TextStyle(
                                    color: _selectedIndex == 2
                                        ? _selectedColor
                                        : Color(0xff80879A)),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 3;
                            _selectedColor = Colors.orangeAccent;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_circle,
                                  color: _selectedIndex == 3
                                      ? _selectedColor
                                      : Color(0xff80879A)),
                              Text(
                                'Profile',
                                style: TextStyle(
                                    color: _selectedIndex == 3
                                        ? _selectedColor
                                        : Color(0xff80879A)),
                              )
                            ],
                          ),
                        ),
                      )
                    ])),
          );
  }
}
