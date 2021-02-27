import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:madhouse_budgeter/screens/Home/home_screen.dart';
import 'package:madhouse_budgeter/screens/thirdscreens.dart';
import 'package:madhouse_budgeter/screens/Home/exspense_form_screen.dart';
import 'package:madhouse_budgeter/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _page = 1;
  final _pageOption = [
    ExpenseFormScreen(),
    HomeScreen(),
    SignUp(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[_page],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blueAccent[100],
        backgroundColor: MadhouseBudgeterTheme.nearlyWhite,
        buttonBackgroundColor: MadhouseBudgeterTheme.dark_grey,
        height: 60,
        items: <Widget>[
          Icon(Icons.settings_applications, size: 25, color: MadhouseBudgeterTheme.nearlyWhite),
          Icon(Icons.home, size: 25, color: MadhouseBudgeterTheme.nearlyWhite),
          Icon(Icons.details, size: 25, color: MadhouseBudgeterTheme.nearlyWhite),
        ],
        animationDuration: Duration(
          milliseconds: 250,
        ),
        index: 1,
        onTap: (index){
          setState(() {
            _page = index;
          });
          debugPrint("Current Index is $index");
        },
      ),
    );
  }
}
