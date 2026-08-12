import 'package:flutter/material.dart';
import '../data/cart_service.dart';
import '../data/order_service.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';
import '../widgets/gradient_button.dart';
import 'payment_method_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // 'cod' = បង់ពេលទទួល, 'online' = បង់អនឡាញ
  String paymentMethod = 'cod';

  String get paymentLabel =>
      paymentMethod == 'cod' ? AppStrings.t('pay_cod') : AppStrings.t('pay_online');

  IconData get paymentIcon =>
      paymentMethod == 'cod' ? Icons.money : Icons.credit_card;

  Future<void> openPaymentMethodScreen() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => PaymentMethodScreen(currentMethod: paymentMethod)),
    );
    if (result != null) {
      setState(() => paymentMethod = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.instance.cartItems;
    final total = CartService.instance.totalPrice;

    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.t('checkout')),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.t('order_summary'),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    boxShadow: AppShadows.card,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => Divider(height: 20, color: AppColors.cardBorder),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.food.localizedName(lang)} x${item.quantity}',
                              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                            ),
                          ),
                          Text(
                            '\$${item.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: openPaymentMethodScreen,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.button),
                      boxShadow: AppShadows.card,
                    ),
                    child: Row(
                      children: [
                        Icon(paymentIcon, color: AppColors.primary, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(paymentLabel, style: const TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadius.button),
                    boxShadow: AppShadows.card,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_offer_outlined, color: AppColors.primary, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(AppStrings.t('promo_code'), style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(AppStrings.t('apply'), style: const TextStyle(color: AppColors.primary, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.t('grand_total'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                GradientButton(
                  label: AppStrings.t('confirm_order'),
                  onPressed: () {
                    OrderService.instance.placeOrder(
                      items: cartItems,
                      total: total,
                      paymentMethod: paymentMethod,
                    );
                    _showSuccessDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 16),
                Text(AppStrings.t('success_title'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 6),
                Text(
                  paymentMethod == 'cod' ? AppStrings.t('order_received_cod') : AppStrings.t('order_received_online'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                ),
                const SizedBox(height: 20),
                GradientButton(
                  label: AppStrings.t('ok'),
                  onPressed: () {
                    CartService.instance.clearCart();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
