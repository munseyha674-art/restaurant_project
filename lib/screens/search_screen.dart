import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/food.dart';
import '../widgets/food_card.dart';
import '../core/app_colors.dart';
import 'food_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Food> searchResults = [];

  void performSearch(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        searchResults = [];
      } else {
        searchResults = dummyFoodList
            .where((food) => food.name.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ស្វែងរក',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder, width: 1),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: performSearch,
                  style: const TextStyle(color: AppColors.textDark, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'ស្វែងរកម្ហូប...',
                    hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textGrey, size: 20),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textGrey, size: 18),
                      onPressed: () {
                        searchController.clear();
                        performSearch('');
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: searchController.text.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 60, color: AppColors.textGrey.withOpacity(0.3)),
                      const SizedBox(height: 12),
                      const Text('វាយឈ្មោះម្ហូបដើម្បីស្វែងរក', style: TextStyle(color: AppColors.textGrey)),
                    ],
                  ),
                )
                    : searchResults.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 60, color: AppColors.textGrey.withOpacity(0.3)),
                      const SizedBox(height: 12),
                      const Text('រកមិនឃើញលទ្ធផល', style: TextStyle(color: AppColors.textGrey)),
                    ],
                  ),
                )
                    : GridView.builder(
                  itemCount: searchResults.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final food = searchResults[index];
                    return FoodCard(
                      food: food,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodDetailScreen(food: food)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}