import 'package:flutter/material.dart';

class OrderInfoProvider extends ChangeNotifier {
  OrderInfo? _orderInfo;

  OrderInfo? get orderInfo => _orderInfo;

  void setOrderInfo(OrderInfo orderInfo) {
    _orderInfo = orderInfo;
    notifyListeners();
  }
}

class OrderInfo {
  final String prescriptionNumber;
  final double amount;

  OrderInfo(this.prescriptionNumber, this.amount);
}
