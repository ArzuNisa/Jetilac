import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: "Settings",
      home: Scaffold(
        appBar: AppBar(title: Text("Ayarlar"),),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              itemProfile('Güvenlik','Şifre, güvenlik, kişisel detaylar' , CupertinoIcons.lock),
              const SizedBox(height: 20),
              itemSettings('Ödeme Yöntemleri', CupertinoIcons.money_dollar),
              const SizedBox(height: 20),
              itemSettings('Dil', CupertinoIcons.book),
              const SizedBox(height: 20),
              itemSettings('Yardım', CupertinoIcons.question),
              const SizedBox(height: 20),
              itemSettings('Hakkında', CupertinoIcons.info),
              const SizedBox(height: 20),
              itemSettings('Çıkış yap', CupertinoIcons.xmark),
              const SizedBox(height: 40),

              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Profile Dön')
                ),
              )
            ],
          ),
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
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }

  itemSettings(String title, IconData iconData){
    return Container(
      height: 70,
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
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }



}
