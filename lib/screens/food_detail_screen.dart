import 'package:flutter/material.dart';
import '../models/food.dart';
import '../data/cart_service.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';
import '../widgets/gradient_button.dart';

class FoodDetailScreen extends StatefulWidget {
  final Food food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            elevation: 0,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            title: Text(
              food.localizedName(lang),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: AppShadows.card,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          child: Image.asset(
                            food.imageUrl,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            color: food.isSoldOut ? Colors.grey : null,
                            colorBlendMode: food.isSoldOut ? BlendMode.saturation : null,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 220,
                                width: double.infinity,
                                color: AppColors.surface,
                                child: const Icon(Icons.restaurant, size: 60, color: AppColors.primary),
                              );
                            },
                          ),
                        ),
                        if (food.isSoldOut)
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.65),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  AppStrings.t('sold_out'),
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              food.localizedName(lang),
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                            ),
                          ),
                          Text(
                            '\$${food.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      Text(
                        AppStrings.t('description'),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        food.localizedDescription(lang),
                        style: const TextStyle(fontSize: 14, color: AppColors.textGrey, height: 1.4),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      Text(
                        AppStrings.t('quantity'),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(AppRadius.button),
                          boxShadow: AppShadows.card,
                        ),
                        child: Row(
                          children: [
                            _qtyButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                            ),
                            Expanded(
                              child: Text(
                                '$quantity',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                              ),
                            ),
                            _qtyButton(
                              icon: Icons.add,
                              onTap: () => setState(() => quantity++),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      Text(
                        AppStrings.t('rate_this_food'),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            final starValue = index + 1;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  food.rating = ((food.rating * food.ratingCount) + starValue) / (food.ratingCount + 1);
                                  food.ratingCount++;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.t('thanks_rating'))),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(Icons.star, size: 28, color: AppColors.primary),
                              ),
                            );
                          }),
                          const SizedBox(width: 10),
                          Text(
                            '${food.rating.toStringAsFixed(1)} (${food.ratingCount} ${AppStrings.t('ratings_label')})',
                            style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: food.isSoldOut
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.textGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      AppStrings.t('sold_out_cannot_order'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                : GradientButton(
                    label: '${AppStrings.t('add_to_cart')} • \$${(food.price * quantity).toStringAsFixed(2)}',
                    onPressed: () {
                      for (int i = 0; i < quantity; i++) {
                        CartService.instance.addToCart(food);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${food.localizedName(lang)}${AppStrings.t('added_to_cart_suffix')}')),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
