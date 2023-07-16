import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'SettingsPage.dart';
import 'order_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name = '';
  late String email = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final doc =
        FirebaseFirestore.instance.collection('profileInfo').doc(user!.uid);

    final snapshot = await doc.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        name = data['isimSoyisim'];
        email = data['eposta'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/Jetilac.png'),
              ),
              const SizedBox(height: 20),
              itemProfile('name'.tr, name, CupertinoIcons.person, context),
              const SizedBox(height: 20),
              itemProfile('id'.tr, '10452536478', CupertinoIcons.number, context),
              const SizedBox(height: 20),
              itemProfile(
                  'phone'.tr, '05385222807', CupertinoIcons.phone, context),
              const SizedBox(height: 20),
              itemProfile('address'.tr, 'Cumhuriyet Mah. Çankaya/ANKARA',
                  CupertinoIcons.location, context),
              const SizedBox(height: 20),
              itemProfile('Email', email, CupertinoIcons.mail, context),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Text('settings'.tr),
                ),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      child: Text("EN"),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.blueGrey.withOpacity(.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    onTap: () {
                      Get.updateLocale(Locale("en", "US"));
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text("TR"),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.blueGrey.withOpacity(.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    onTap: () {
                      Get.updateLocale(Locale("tr", "TR"));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:CurvedNavigationBar(
        backgroundColor: Colors.blueGrey,
        items: <Widget>[
          Icon(Icons.shopping_cart_outlined, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          if(index==0){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OrderingPage(),
              ),
            );
          }
          else if(index==1){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget itemProfile(
      String title, String subtitle, IconData iconData, BuildContext context) {
    return Container(
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
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyText2),
        leading: Icon(iconData, color: Colors.black54),
      ),
    );
  }
}
