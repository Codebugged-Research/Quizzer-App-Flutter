import 'package:flutter/material.dart';
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
    MemberScreen(),
    RewardScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity), label: 'Quiz'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity), label: 'Be the Member'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity), label: 'Reward'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xff80879A),
        selectedItemColor: Colors.lightBlue.shade300,
        elevation: 20.0,
        backgroundColor: Color(0xffFFFFFF),
        onTap: _onItemTapped,
      ),
    );
  }
}
