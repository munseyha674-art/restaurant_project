import 'package:flutter/material.dart';
import '../data/cart_service.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';
import '../widgets/gradient_button.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  // ប្រើពេល CartScreen ជា tab ក្នុង bottom nav (IndexedStack) —
  // ដើម្បីប្រាប់ MainScreen ថាត្រូវប្តូរទៅ Home tab វិញ
  final VoidCallback? onGoHome;

  const CartScreen({super.key, this.onGoHome});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.instance.cartItems;
    final total = CartService.instance.totalPrice;

    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else if (widget.onGoHome != null) {
                  widget.onGoHome!();
                }
              },
            ),
            title: Text(AppStrings.t('your_cart')),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: cartItems.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 70, color: AppColors.textGrey.withOpacity(0.4)),
                  const SizedBox(height: 12),
                  Text(AppStrings.t('cart_empty'), style: const TextStyle(color: AppColors.textGrey)),
                ],
              ),
            )
                : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          boxShadow: AppShadows.card,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item.food.imageUrl,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 55,
                                    height: 55,
                                    color: AppColors.surface,
                                    child: const Icon(Icons.restaurant, size: 18, color: AppColors.primary),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.food.localizedName(lang), style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 4),
                                  Text('\$${item.food.price.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ),
                            _qtyButton(
                              icon: Icons.remove,
                              onTap: () {
                                setState(() {
                                  if (item.quantity > 1) {
                                    item.quantity--;
                                    CartService.instance.itemCount.value =
                                        CartService.instance.cartItems.fold(0, (sum, i) => sum + i.quantity);
                                  } else {
                                    CartService.instance.removeFromCart(item.food.id);
                                  }
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('${item.quantity}', style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
                            ),
                            _qtyButton(
                              icon: Icons.add,
                              onTap: () {
                                setState(() {
                                  item.quantity++;
                                  CartService.instance.itemCount.value =
                                      CartService.instance.cartItems.fold(0, (sum, i) => sum + i.quantity);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  _infoRow(icon: Icons.location_on_outlined, label: AppStrings.t('delivery_address_label'), value: '123 Main St, Phnom Penh'),
                  const SizedBox(height: 10),
                  _infoRow(icon: Icons.payment_outlined, label: AppStrings.t('payment_method'), value: 'Cash on Delivery'),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: AppShadows.card,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.t('total'), style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
                            Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        GradientButton(
                          label: AppStrings.t('checkout'),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.button),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
                Text(value, style: const TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 18),
        ],
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: AppColors.primary),
      ),
    );
  }
}