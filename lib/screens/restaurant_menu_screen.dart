import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../data/dummy_data.dart';
import '../widgets/food_card.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import 'food_detail_screen.dart';

class RestaurantMenuScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantMenuScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final menu = dummyFoodList.where((f) => f.restaurantId == restaurant.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: menu.isEmpty
          ? const Center(child: Text('មិនទាន់មានមុខម្ហូប', style: TextStyle(color: AppColors.textGrey)))
          : Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: GridView.builder(
                itemCount: menu.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final food = menu[index];
                  return FoodCard(
                    food: food,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailScreen(food: food)));
                    },
                  );
                },
              ),
            ),
    );
  }
}
