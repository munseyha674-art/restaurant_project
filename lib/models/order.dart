import 'cart_item.dart';
import '../core/app_language.dart';

class Order {
  final int id;
  final List<CartItem> items;
  final double total;
  final String paymentMethod; // 'cod' or 'online'
  final DateTime date;
  int statusIndex; // 0 = Preparing, 1 = On the way, 2 = Delivered

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.date,
    this.statusIndex = 0,
  });

  static const Map<AppLanguage, List<String>> _statusLabels = {
    AppLanguage.km: ['កំពុងរៀបចំ', 'កំពុងដឹកជញ្ជូន', 'បានទទួល'],
    AppLanguage.en: ['Preparing', 'On the way', 'Delivered'],
  };

  String statusLabelFor(AppLanguage lang) => _statusLabels[lang]![statusIndex];
}
