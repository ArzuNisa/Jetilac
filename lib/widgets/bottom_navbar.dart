import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black54,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_sharp),
          label: "Nöbetçi eczane",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: "Ayarlar",
        ),
      ],
    );
  }
}
class CustomFloatingButtomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.teal,
          elevation: 20,
          onPressed: () {  },
          child: Icon(Icons.maps_home_work_outlined,size: 30.0),
        ),
      ),
    );
  }
}