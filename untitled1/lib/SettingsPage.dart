import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/AboutPage.dart';
import 'package:untitled1/HelpPage.dart';
import 'package:untitled1/LanguagePage.dart';
import 'package:untitled1/PaymentMethodsPage.dart';
import 'package:untitled1/PharmacyPage.dart';
import 'package:untitled1/ProfileScreen.dart';
import 'package:untitled1/SecurityPage.dart';
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
        appBar: AppBar(title: Text('settings'.tr),),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              itemProfile('security'.tr,'psw'.tr , CupertinoIcons.lock, context),
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
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    },
                    child: Text('btprofile'.tr)
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PharmacyPage()));
                    },
                    child: Text('pharmacy'.tr)
                ),
              ),
            ],
          ),
        ),
        ),
      );
  }

  itemProfile(String title, String subtitle, IconData iconData, BuildContext context){
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecurityPage()));
        },
          child:Container(
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
              title: Text(title, style: Theme.of(context).textTheme.headline6),
              subtitle: Text(title, style: Theme.of(context).textTheme.bodyText2),
              leading: Icon(iconData, color: Colors.black54),
              trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
            ),
          ),
    );
  }

  itemSettings(String title, IconData iconData, BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
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
  itemSettings2(String title, IconData iconData, BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
      },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
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
  itemSettings3(String title, IconData iconData, BuildContext context){
    return InkWell(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodsPage()));
      },
    );
  }

  itemSettings4(String title, IconData iconData, BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white70,
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
