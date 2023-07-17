import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'success.dart';

class OrderInfo {
  final String prescriptionNumber;
  final double amount;

  OrderInfo(this.prescriptionNumber, this.amount);
}

class OrderInfoProvider extends ChangeNotifier {
  OrderInfo? _orderInfo;

  OrderInfo? get orderInfo => _orderInfo;

  void setOrderInfo(OrderInfo orderInfo) {
    _orderInfo = orderInfo;
    notifyListeners();
  }
}

class Payment extends StatefulWidget {
  final String prescriptionNumber;

  const Payment({Key? key, required this.prescriptionNumber}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;
  final paymentLabels = ['Kredi Kartı / Banka Kartı', 'Kapıda Ödeme'];
  final paymentIcons = [Icons.credit_card, Icons.attach_money];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? cardNumber;
  String? cardHolderName;
  String? expirationDate;
  String? cvv;
  bool isPaymentCompleted = false;

  late double amount;

  double getRandomAmount() {
    final random = Random();
    return random.nextDouble() * 100 + 10;
  }

  @override
  void initState() {
    super.initState();
    amount = getRandomAmount();
  }

  @override
  Widget build(BuildContext context) {
    final orderInfoProvider = Provider.of<OrderInfoProvider>(context);
    final orderInfo = OrderInfo(widget.prescriptionNumber, amount);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ödeme'),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child:Table( // Allows to dd a border decoration around your table
                      children: [
                        TableRow(children :[
                          Text("Reçete Numarası"),
                          Text(': ${widget.prescriptionNumber}'),
                        ]),
                        TableRow(children :[
                          Text('Tutar'),
                          Text(': ${amount.toStringAsFixed(2)} TL'),
                        ]),
                      ]
                  ) ,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Ödeme Yöntemini Seçiniz',
              style: TextStyle(color: Colors.red, fontSize: 28.0),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: Colors.red,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i!),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    paymentIcons[index],
                    color: Colors.black,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          if (value != 1)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Kart Bilgilerinizi Giriniz',
                style: TextStyle(color: Colors.red, fontSize: 28.0),
              ),
            ),
          if (value == 0)
            Padding(
              padding: const EdgeInsets.only(right: 20.0,left: 20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Kart Numarası',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kart numarası boş olamaz';
                          }
                          String strippedText =
                              value.replaceAll(RegExp(r'\s+\b|\b\s'), '');
                          if (strippedText.length != 16) {
                            return 'Kart numarası 16 haneli olmalıdır';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          cardNumber = value;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          _CardNumberFormatter(),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Kart Sahibi Adı',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kart sahibi adı boş olamaz';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          cardHolderName = value;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Son Kullanma Tarihi (AA/YY)',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Son kullanma tarihi boş olamaz';
                                }
                                if (!value.contains('/') || value.length != 5) {
                                  return 'Geçerli bir son kullanma tarihi giriniz (AA/YY)';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                expirationDate = value;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CVV',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'CVV boş olamaz';
                                }
                                if (value.length != 3) {
                                  return 'CVV 3 haneli olmalıdır';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                cvv = value;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      isPaymentCompleted
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 48,
                            )
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    isPaymentCompleted = true;
                                  });
                                }
                              },
                              child: Text('Öde'),
                            ),
                      if (isPaymentCompleted)
                        ElevatedButton(
                          onPressed: () {
                            orderInfoProvider.setOrderInfo(orderInfo);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Success(),
                              ),
                            );
                          },
                          child: Text('Siparişi Tamamla'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          if (value == 1)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  orderInfoProvider.setOrderInfo(orderInfo);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Success(),
                    ),
                  );
                },
                child: Text('Siparişi Tamamla'),
              ),
            ),
        ],
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (oldValue.text.length >= newText.length) {
      return newValue;
    }

    final formattedText = _getFormattedText(newText);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _getFormattedText(String text) {
    final strippedText = text.replaceAll(' ', '');
    final formattedText = <String>[];

    for (var i = 0; i < strippedText.length; i += 4) {
      final end = i + 4;
      if (end <= strippedText.length) {
        final part = strippedText.substring(i, end);
        formattedText.add(part);
      } else {
        final part = strippedText.substring(i);
        formattedText.add(part);
      }
    }

    return formattedText.join(' ');
  }
}
