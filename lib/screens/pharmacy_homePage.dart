import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/SettingsPage.dart';
import 'incoming_ordersPage.dart';
class PharmacyHomePage extends StatefulWidget {
  const PharmacyHomePage({Key? key}) : super(key: key);

  @override
  State<PharmacyHomePage> createState() => _PharmacyHomePageState();
}

class _PharmacyHomePageState extends State<PharmacyHomePage> {
  int currentIndex =0;
  final screens=[
    IncomingOrders(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar:CurvedNavigationBar(
          height: 60.0,
          backgroundColor: Colors.lightBlueAccent,
          items: <Widget>[
            Icon(Icons.shopping_cart, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          onTap: (index) => setState(() => currentIndex =index),
        ),
    );
  }
}
