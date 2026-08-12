import 'package:flutter/material.dart';
import '../models/food.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return GestureDetector(
          onTap: food.isSoldOut ? null : onTap,
          child: Opacity(
            opacity: food.isSoldOut ? 0.55 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.card),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
                        child: Image.asset(
                          food.imageUrl,
                          height: 110,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          color: food.isSoldOut ? Colors.grey : null,
                          colorBlendMode: food.isSoldOut ? BlendMode.saturation : null,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 110,
                              width: double.infinity,
                              color: AppColors.surface,
                              child: const Icon(Icons.restaurant, size: 32, color: AppColors.primary),
                            );
                          },
                        ),
                      ),
                      if (food.isSoldOut)
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.65),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                AppStrings.t('sold_out'),
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.localizedName(lang),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 13, color: Colors.amber),
                            const SizedBox(width: 3),
                            Text(
                              food.rating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${food.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.primary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                gradient: food.isSoldOut ? null : AppColors.primaryGradient,
                                color: food.isSoldOut ? AppColors.textGrey : null,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, size: 16, color: Colors.white),
                            ),
                          ],
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
}
