import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled1/LangUpdate.dart';
import 'package:untitled1/Theme.dart';
import 'ProfileScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Lang(),
      locale: Get.locale == null?Get.deviceLocale:Get.locale ,
      fallbackLocale: Lang.putative,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      home: const ProfileScreen(),
    );
  }
}
