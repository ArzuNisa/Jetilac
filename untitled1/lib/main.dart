import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled1/LangUpdate.dart';
import 'package:untitled1/SettingsPage.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/Jetilac.png'),
            ),
            const SizedBox(height: 20),
            itemProfile('name'.tr, 'Arzu Nisa Yalcınkaya', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile('id'.tr, '10452536478', CupertinoIcons.number),
            const SizedBox(height: 20),
            itemProfile('phone'.tr, '05385222807', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemProfile('address'.tr, 'Cumhuriyet Mah. Çankaya/ANKARA', CupertinoIcons.location),
            const SizedBox(height: 20),
            itemProfile('Email', 'bursiyer@gmail.com', CupertinoIcons.mail),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Text('settings'.tr)),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    child: Text("EN"),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        color: Colors.white,
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

  itemProfile(String title, String subtitle, IconData iconData){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.blueGrey.withOpacity(.3),
                spreadRadius: 5,
                blurRadius: 5
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}



