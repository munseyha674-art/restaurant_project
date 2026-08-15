import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/food_card.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import 'food_detail_screen.dart';

class CategoryFoodScreen extends StatelessWidget {
  final String category; // 'food', 'drink', or 'dessert'
  final String categoryLabel; // already-translated title to show

  const CategoryFoodScreen({
    super.key,
    required this.category,
    required this.categoryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = dummyFoodList.where((f) => f.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryLabel),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: filtered.isEmpty
          ? const Center(child: Text('មិនទាន់មានទំនិញ', style: TextStyle(color: AppColors.textGrey)))
          : Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: GridView.builder(
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final food = filtered[index];
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
