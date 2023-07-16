import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'incoming_ordersPage.dart';
import 'orders.dart';

class PharmacyHomePage extends StatefulWidget {
  const PharmacyHomePage({Key? key}) : super(key: key);

  @override
  State<PharmacyHomePage> createState() => _PharmacyHomePageState();
}

class _PharmacyHomePageState extends State<PharmacyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderInfoProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ana Sayfa"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IncomingOrders()),
                  );
                },
                child: Text("Gelen Siparişler"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
