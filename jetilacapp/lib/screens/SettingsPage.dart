import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens//AboutPage.dart';
import 'package:testapp/screens/HelpPage.dart';
import 'package:testapp/screens/LanguagePage.dart';
import 'package:testapp/screens/PaymentMethodsPage.dart';
import 'package:testapp/screens/PharmacyPage.dart';
import 'package:testapp/screens/SecurityPage.dart';
import 'package:get/get.dart';
import 'Theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      title: "Settings",
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 400,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(15)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "settings".tr,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.white70),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                itemProfile(
                    'security'.tr, 'psw'.tr, CupertinoIcons.lock, context),
                const SizedBox(height: 20),
                itemSettings3('pay'.tr, CupertinoIcons.money_dollar, context),
                const SizedBox(height: 20),
                itemSettings4('lang'.tr, CupertinoIcons.book, context),
                const SizedBox(height: 20),
                itemSettings2('help'.tr, CupertinoIcons.question, context),
                const SizedBox(height: 20),
                itemSettings('about'.tr, CupertinoIcons.info, context),
                const SizedBox(height: 20),
                itemSettings('exit'.tr, CupertinoIcons.xmark, context),
                const SizedBox(height: 20),
                SizedBox(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PharmacyPage()));
                      },
                      child: Text(
                        'btprofile'.tr,
                        style: TextStyle(letterSpacing: 1, fontSize: 15),
                      )),
                ),
                SizedBox(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PharmacyPage()));
                      },
                      child: Text(
                        'pharmacy'.tr,
                        style: TextStyle(letterSpacing: 1, fontSize: 15),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  itemProfile(
      String title, String subtitle, IconData iconData, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecurityPage()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.white70,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  color: Colors.blueGrey.withOpacity(.3),
                  spreadRadius: 5,
                  blurRadius: 5)
            ]),
        child: ListTile(
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          subtitle: Text(title, style: Theme.of(context).textTheme.bodyText2),
          leading: Icon(iconData, color: Colors.black54),
          trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        ),
      ),
    );
  }

  itemSettings(String title, IconData iconData, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.blueGrey.withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          leading: Icon(iconData, color: Colors.black54),
          trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        ),
      ),
    );
  }

  itemSettings2(String title, IconData iconData, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpPage()));
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.blueGrey.withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          leading: Icon(iconData, color: Colors.black54),
          trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        ),
      ),
    );
  }

  itemSettings3(String title, IconData iconData, BuildContext context) {
    return InkWell(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.blueGrey.withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          leading: Icon(iconData, color: Colors.black54),
          trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PaymentMethodsPage()));
      },
    );
  }

  itemSettings4(String title, IconData iconData, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LanguagePage()));
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.blueGrey.withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          leading: Icon(iconData, color: Colors.black54),
          trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
