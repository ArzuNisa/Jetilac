import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: "Language",
      home: Scaffold(
        appBar: AppBar(title: Text('lang'.tr),),
        body:
        SizedBox(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('btsettings'.tr)
          ),
        ),
      ),
    );
  }
}

