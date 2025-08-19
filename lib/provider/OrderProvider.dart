import 'package:flutter/material.dart';
import 'package:pharma_app/model/Order.dart';
import 'package:pharma_app/service/OrderService.dart';

enum OrderStatus { idle, loading, success, error }

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  OrderStatus _status = OrderStatus.idle;
  OrderStatus get status => _status;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> submitOrder(Order order) async {
    _status = OrderStatus.loading;
    notifyListeners();

    bool success = await _orderService.submitOrder(order);

    if (success) {
      _status = OrderStatus.success;
    } else {
      _status = OrderStatus.error;
      _errorMessage = "Failed to submit order. Please try again.";
    }
    notifyListeners();
  }

  void reset() {
    _status = OrderStatus.idle;
    _errorMessage = '';
    notifyListeners();
  }
}
