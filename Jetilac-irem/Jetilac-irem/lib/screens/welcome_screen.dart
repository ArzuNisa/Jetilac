import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/login_page_view.dart';
import 'package:testapp/screens/pharmacist_loginpage.dart';

import 'LangUpdate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Lang(),
      locale: Get.locale == null?Get.deviceLocale:Get.locale ,
      fallbackLocale: Lang.putative,
      title: 'Jetilaç',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('welcome'.tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageView()),
                );
              },
              child: Text('lfu'.tr),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PharmacistLoginPage()),
                );
              },
              child: Text('lfp'.tr),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    child: Text("EN"),
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.blueGrey.withOpacity(.3),
                              spreadRadius: 5,
                              blurRadius: 5
                          )
                        ]
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  onTap: (){
                    Get.updateLocale(Locale("en","US"));
                  },
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text("TR"),
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.blueGrey.withOpacity(.3),
                              spreadRadius: 5,
                              blurRadius: 5
                          )
                        ]
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  onTap: (){
                    Get.updateLocale(Locale("tr","TR"));
                  },
                )
              ],
            ),
          ],

        ),
      ),
    );
  }
}
