import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'payment_page.dart';

class IncomingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderInfoProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('incoming orders'.tr),
        ),
        body: Center(
          child: Consumer<OrderInfoProvider>(
            builder: (context, orderInfoProvider, _) {
              final OrderInfo? orderInfo = orderInfoProvider.orderInfo;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'prescription number'.tr + ': ${orderInfo?.prescriptionNumber ?? '12ASDFGH'}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'amount'.tr + ': ${orderInfo?.amount.toStringAsFixed(2) ?? '55'} TL',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
