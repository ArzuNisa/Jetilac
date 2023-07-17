import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jetilac/screens/login_screen.dart';
import 'package:jetilac/screens/register_screen.dart';
import 'package:jetilac/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
