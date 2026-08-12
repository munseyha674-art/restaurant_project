import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../models/food.dart';
import '../../core/app_colors.dart';
import '../../core/app_style.dart';
import 'food_form_screen.dart';

class ManageMenuScreen extends StatefulWidget {
  const ManageMenuScreen({super.key});

  @override
  State<ManageMenuScreen> createState() => _ManageMenuScreenState();
}

class _ManageMenuScreenState extends State<ManageMenuScreen> {
  Future<void> _openAddForm() async {
    final result = await Navigator.push<Food>(
      context,
      MaterialPageRoute(builder: (context) => const FoodFormScreen()),
    );
    if (result != null) {
      setState(() => dummyFoodList.add(result));
    }
  }

  Future<void> _openEditForm(Food food) async {
    final result = await Navigator.push<Food>(
      context,
      MaterialPageRoute(builder: (context) => FoodFormScreen(existingFood: food)),
    );
    if (result != null) {
      setState(() {
        final index = dummyFoodList.indexWhere((f) => f.id == food.id);
        if (index != -1) dummyFoodList[index] = result;
      });
    }
  }

  void _confirmDelete(Food food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text('លុបមុខម្ហូប?'),
        content: Text('តើអ្នកចង់លុប "${food.name}" មែនទេ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('បោះបង់'),
          ),
          TextButton(
            onPressed: () {
              setState(() => dummyFoodList.removeWhere((f) => f.id == food.id));
              Navigator.pop(context);
            },
            child: const Text('លុប', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('គ្រប់គ្រងមុខម្ហូប'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _openAddForm,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: dummyFoodList.length,
        itemBuilder: (context, index) {
          final food = dummyFoodList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
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
                    food.imageUrl,
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 55,
                      height: 55,
                      color: AppColors.surface,
                      child: const Icon(Icons.restaurant, color: AppColors.primary, size: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('\$${food.price.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
                      if (food.isSoldOut) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('អស់ស្តុក', style: TextStyle(color: AppColors.danger, fontSize: 10, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textGrey),
                  onPressed: () => _openEditForm(food),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.danger),
                  onPressed: () => _confirmDelete(food),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
