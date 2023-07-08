import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: "Help",
      home: Scaffold(
        appBar: AppBar(title: Text('help'.tr),),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [Container(
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('support'.tr),
                    SizedBox(height: 8.0),
                  ],
                ),
                subtitle: Text('info'.tr),
                tileColor: Colors.white,
              ),
            ),
              const SizedBox(height: 20),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:  Text('btsettings'.tr)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

