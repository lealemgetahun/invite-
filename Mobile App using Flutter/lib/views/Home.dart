
import 'package:flutter/material.dart';
import 'package:online_customer_care/views/company.dart';

import 'homeContent.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentNav =0;
  List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    CompanyListD()
    ];
  @override
  void initState() {

    super.initState();
  }

  void _getNavigationPage(int index) {
    setState(() {
      _currentNav = index;
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrange, Colors.grey])),
            child: _widgetOptions.elementAt(_currentNav)
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.grey),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Companies', style: TextStyle(color: Colors.grey))),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentNav,
          onTap: _getNavigationPage,
          selectedItemColor: Colors.deepOrange,
        ),
      ),
    );
  }

}
