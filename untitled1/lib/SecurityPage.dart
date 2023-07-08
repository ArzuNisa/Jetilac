import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: "Security",
      home: Scaffold(
        appBar: AppBar(title: Text('security'.tr),),
          body:
          SizedBox(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('btsettings'.tr)
            ),
          ),
      ),
    );
  }
}

