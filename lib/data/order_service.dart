import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

class OrderService {
  static final OrderService instance = OrderService._internal();
  OrderService._internal();

  final ValueNotifier<List<Order>> orders = ValueNotifier<List<Order>>([]);

  Order placeOrder({
    required List<CartItem> items,
    required double total,
    required String paymentMethod,
  }) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch,
      // ចម្លងបញ្ជីទំនិញនៅពេលកម្មង់ ដើម្បីកុំអោយប៉ះពាល់បើ cart ត្រូវលុបក្រោយមក
      items: items.map((item) => CartItem(food: item.food, quantity: item.quantity)).toList(),
      total: total,
      paymentMethod: paymentMethod,
      date: DateTime.now(),
    );

    orders.value = [order, ...orders.value];
    _simulateProgress(order);
    return order;
  }

  // ធ្វើអោយការកម្មង់រីកចម្រើនស្ថានភាពដោយស្វ័យប្រវត្តិ (សាកល្បង/demo only)
  void _simulateProgress(Order order) {
    Timer(const Duration(seconds: 8), () {
      if (order.statusIndex < 2) {
        order.statusIndex++;
        orders.notifyListeners();
        _simulateProgress(order);
      }
    });
  }
}
