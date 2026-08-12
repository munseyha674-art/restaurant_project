import 'package:flutter/material.dart';
import '../data/dummy_restaurants.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import 'restaurant_menu_screen.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ភោជនីយដ្ឋានទាំងអស់'),
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: dummyRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = dummyRestaurants[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantMenuScreen(restaurant: restaurant)));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.card),
                boxShadow: AppShadows.card,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppRadius.card)),
                    child: Image.asset(
                      restaurant.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 90,
                        height: 90,
                        color: AppColors.surface,
                        child: const Icon(Icons.storefront, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 14),
                    child: Icon(Icons.chevron_right, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
