import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:testapp/screens/HomePage.dart';
import 'package:testapp/screens/ProfileScreen.dart';
import 'package:testapp/screens/order_page.dart';
import 'package:testapp/screens/pharmacist_loginpage.dart';
import 'package:testapp/screens/pharmacy_homePage.dart';
import 'package:testapp/screens/welcome_screen.dart';
import 'Theme.dart';
import 'LangUpdate.dart';
import 'orders.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderInfoProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Lang(),
      locale: Get.locale == null ? Get.deviceLocale : Get.locale,
      fallbackLocale: Lang.putative,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: PharmacyLogin(),
    );
  }
}
