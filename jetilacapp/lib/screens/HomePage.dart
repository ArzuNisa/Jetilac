import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ProfileScreen.dart';
import 'order_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex =0;

  final screens =[
    OrderingPage(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar:CurvedNavigationBar(
        height: 60.0,
      backgroundColor: Colors.blueGrey,
      items: <Widget>[
        Icon(Icons.shopping_cart, size: 30),
        Icon(Icons.settings, size: 30),
      ],
          onTap: (index) => setState(() => currentIndex =index),
    ),
      /*BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white38,
        unselectedItemColor: Colors.white38,
        iconSize: 20,
        selectedFontSize: 20,
        unselectedFontSize: 16,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex =index),
        backgroundColor: Colors.blueGrey.withOpacity(0.2),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
              label: "Shopping page",backgroundColor: Colors.blueGrey
          ),
          BottomNavigationBarItem(icon:Icon(Icons.settings),
              label: "Settings",backgroundColor: Colors.blueGrey)
        ],
      ),*/
    );
  }
}
