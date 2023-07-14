import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  final paymentLabels = ['ccard'.tr, 'pay at the door'.tr];
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
        title: Text('payment'.tr),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'prescription number'.tr + ': ${widget.prescriptionNumber}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    'amount'.tr +': ${amount.toStringAsFixed(2)} TL',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'choose payment method'.tr,
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
          SizedBox(height: 20),
          if (value != 1)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'enter your card information'.tr,
                style: TextStyle(color: Colors.red, fontSize: 28.0),
              ),
            ),
          if (value == 0)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'card number'.tr,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'card number cannot be blank'.tr;
                        }
                        String strippedText =
                            value.replaceAll(RegExp(r'\s+\b|\b\s'), '');
                        if (strippedText.length != 16) {
                          return 'cnmbd'.tr;
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
                        labelText: 'card holder name'.tr,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'chncbe'.tr;
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
                              labelText: 'expiry date'.tr,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'edcbe'.tr;
                              }
                              if (!value.contains('/') || value.length != 5) {
                                return 'eavedmy'.tr;
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
                                return 'cvvcbe'.tr;
                              }
                              if (value.length != 3) {
                                return 'cvvmbetd'.tr;
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
                            child: Text('payy'.tr),
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
                        child: Text('complete order'.tr),
                      ),
                  ],
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
                child: Text('complete order'.tr),
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
