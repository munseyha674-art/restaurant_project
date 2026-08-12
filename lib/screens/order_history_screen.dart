import 'package:flutter/material.dart';
import '../data/order_service.dart';
import '../models/order.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  Color _statusColor(int statusIndex) {
    switch (statusIndex) {
      case 0:
        return AppColors.primary; // Preparing
      case 1:
        return Colors.blue; // On the way
      default:
        return AppColors.success; // Delivered
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.t('order_history')),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: ValueListenableBuilder<List<Order>>(
            valueListenable: OrderService.instance.orders,
            builder: (context, orders, child) {
              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_outlined, size: 70, color: AppColors.textGrey.withOpacity(0.4)),
                      const SizedBox(height: 12),
                      Text(AppStrings.t('no_orders_yet'), style: const TextStyle(color: AppColors.textGrey)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final itemsSummary = order.items.map((i) => '${i.food.localizedName(lang)} x${i.quantity}').join(', ');
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: AppShadows.card,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.receipt_outlined, color: AppColors.primary, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemsSummary,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${order.date.day}/${order.date.month}/${order.date.year}',
                                    style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${order.total.toStringAsFixed(2)}',
                              style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // ស្ថានភាព 3 ដំណាក់កាល
                        Row(
                          children: List.generate(3, (i) {
                            final isActive = i <= order.statusIndex;
                            return Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: isActive ? _statusColor(order.statusIndex) : AppColors.cardBorder,
                                  ),
                                  if (i < 2)
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: i < order.statusIndex ? _statusColor(order.statusIndex) : AppColors.cardBorder,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _statusColor(order.statusIndex).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            order.statusLabelFor(lang),
                            style: TextStyle(color: _statusColor(order.statusIndex), fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
