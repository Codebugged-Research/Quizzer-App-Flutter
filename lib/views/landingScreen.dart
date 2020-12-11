import 'package:flutter/material.dart';
import 'package:quiz_app/components/drawerComponent.dart';
import 'package:quiz_app/views/Home/homeScreen.dart';
import 'package:quiz_app/views/Member/memberScreen.dart';
import 'package:quiz_app/views/Profile/profileScreen.dart';
import 'package:quiz_app/views/Quiz/quizScreen.dart';
import 'package:quiz_app/views/Reward/rewardScreen.dart';

class LandingScreen extends StatefulWidget {
  final int selectedIndex;
  LandingScreen({this.selectedIndex});
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  bool isLoading = false;
  Color _selectedColor = Colors.lightBlue.shade300;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    // loadDataForScreen();
  }

  loadDataForScreen() async {
    setState(() {
      isLoading = true;
    });
    // user = await UserService.getUser();
    setState(() {
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    QuizScreen(),
    RewardScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         elevation: 0,
        title: Text(
          'Quiz Adda',
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
      ),
      drawer: Drawer(
        child: DrawerComponent(),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _widgetOptions.elementAt(_selectedIndex),

      floatingActionButton: FloatingActionButton(
          tooltip: 'Be the Member',
          backgroundColor: Colors.lightBlue.shade300,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MemberScreen();
            }));
          },
          child: Icon(
            Icons.military_tech,
            size: 30,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                      _selectedColor = Colors.lightBlue.shade300;
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
                      _selectedColor = Colors.lightBlue.shade300;
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
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                      _selectedColor = Colors.lightBlue.shade300;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 12.0, bottom: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_events,
                            color: _selectedIndex == 2
                                ? _selectedColor
                                : Color(0xff80879A)),
                        Text(
                          'Rank',
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
                      _selectedColor = Colors.lightBlue.shade300;
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

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.dynamic_form), label: 'Quiz'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.military_tech), label: 'Be the Member'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.emoji_events), label: 'Reward'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   unselectedItemColor: Color(0xff80879A),
      //   selectedItemColor: Colors.lightBlue.shade300,
      //   elevation: 20.0,
      //   backgroundColor: Color(0xffFFFFFF),
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
