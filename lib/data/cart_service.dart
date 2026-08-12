import 'package:flutter/foundation.dart';
import '../models/food.dart';
import '../models/cart_item.dart';

class CartService {
  // Singleton pattern - app មានតែ CartService object តែមួយប៉ុណ្ណោះ
  static final CartService instance = CartService._internal();
  CartService._internal();

  List<CartItem> cartItems = [];

  // Any widget can "listen" to this number and auto-rebuild when it changes —
  // that's how the cart badge on the bottom nav stays in sync even though
  // addToCart() is called from a totally different screen (food detail).
  final ValueNotifier<int> itemCount = ValueNotifier<int>(0);

  void _recalculateCount() {
    itemCount.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(Food food) {
    // ពិនិត្យមើលថាតើ food នេះមានក្នុង cart រួចហើយឬនៅ
    int index = cartItems.indexWhere((item) => item.food.id == food.id);

    if (index >= 0) {
      // បើមានរួចហើយ បន្ថែម quantity
      cartItems[index].quantity++;
    } else {
      // បើមិនទាន់មាន បន្ថែមថ្មី
      cartItems.add(CartItem(food: food));
    }
    _recalculateCount();
  }

  void removeFromCart(int foodId) {
    cartItems.removeWhere((item) => item.food.id == foodId);
    _recalculateCount();
  }

  void clearCart() {
    cartItems.clear();
    _recalculateCount();
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.totalPrice;
    }
    return total;
  }
}