import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Theme.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      title: "PaymentMethods",
      home: Scaffold(
        appBar: AppBar(title: Text("pay".tr),),
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

