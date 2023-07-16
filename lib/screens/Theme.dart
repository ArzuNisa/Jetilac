import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black54), // Örnek olarak bodyMedium kullanıldı
    ),
  );

}