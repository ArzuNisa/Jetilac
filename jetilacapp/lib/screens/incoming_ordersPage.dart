import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_page.dart';

class IncomingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderInfoProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 400,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Gelen siparişler",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white70
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Consumer<OrderInfoProvider>(
                builder: (context, orderInfoProvider, _) {
                  final OrderInfo? orderInfo = orderInfoProvider.orderInfo;

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ListTile(title: Text("Yeni siparişiniz var",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.shopping_cart,size: 40,color: Colors.lightBlue,),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Reçete Numarası: ${orderInfo?.prescriptionNumber ?? '12ASDFGH'}',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          'Tutar: ${orderInfo?.amount.toStringAsFixed(2) ?? '55'} TL',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*Text(
'Reçete Numarası: ${orderInfo?.prescriptionNumber ?? '12ASDFGH'}',
style: TextStyle(fontSize: 20),
),
Text(
'Tutar: ${orderInfo?.amount.toStringAsFixed(2) ?? '55'} TL',
style: TextStyle(fontSize: 20),
)*/