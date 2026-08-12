import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/food_card.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import 'food_detail_screen.dart';

class AllFoodScreen extends StatelessWidget {
  const AllFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('មុខម្ហូបទាំងអស់'),
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: GridView.builder(
          itemCount: dummyFoodList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final food = dummyFoodList[index];
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
