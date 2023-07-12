import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      title: "About",
      home: Scaffold(
        appBar: AppBar(title: Text('about'.tr),),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [Container(
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
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('about the app'.tr, style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 8.0),
                  ],
                ),
                subtitle: Text('big About'.tr, style: Theme.of(context).textTheme.bodyText2),
              ),
            ),
              const SizedBox(height: 20),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('btsettings'.tr)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
