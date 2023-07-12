import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SettingsPage.dart';

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pharmacy'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/eczane.png'),
              backgroundColor: Colors.red,
            ),
            const SizedBox(height: 20),
            itemProfile('name'.tr, 'Jet Eczane', CupertinoIcons.person, context),
            const SizedBox(height: 20),
            itemProfile('phone'.tr, '03525222807', CupertinoIcons.phone, context),
            const SizedBox(height: 20),
            itemProfile('address'.tr, 'Cumhuriyet Mah. Çankaya/ANKARA', CupertinoIcons.location, context),
            const SizedBox(height: 20),
            itemProfile('Email', 'bursiyer@gmail.com', CupertinoIcons.mail, context),
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
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData, BuildContext context){
    return Container(
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
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyText2),
        leading: Icon(iconData, color: Colors.black54),
      ),
    );
  }
}
