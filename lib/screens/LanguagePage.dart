import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Theme.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      title: "Language",
      home: Scaffold(
        appBar: AppBar(title: Text('lang'.tr),),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('en'.tr,style: Theme.of(context).textTheme.headline6),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
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
                ),
                onTap: (){
                  Get.updateLocale(Locale("en","US"));
                },
              ),
              const SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('tr'.tr,style: Theme.of(context).textTheme.headline6),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
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
                ),
                onTap: (){
                  Get.updateLocale(Locale("tr","TR"));
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: Text('btsettings'.tr)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

