import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/food.dart';
import '../widgets/food_card.dart';
import '../core/app_colors.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';
import 'food_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  // ប្រើពេល SearchScreen ជា tab ក្នុង bottom nav (IndexedStack) —
  // ដើម្បីប្រាប់ MainScreen ថាត្រូវប្តូរទៅ Home tab វិញ
  final VoidCallback? onGoHome;

  const SearchScreen({super.key, this.onGoHome});

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
            .where((food) => food.name.toLowerCase().contains(keyword.toLowerCase()) ||
            food.nameEn.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  // បើមកពី Home search bar (ជា pushed page ពិតប្រាកដ) — ត្រឡប់ទៅ Home
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else if (widget.onGoHome != null) {
                  // បើមកពី bottom nav tab (IndexedStack, គ្មាន route ត្រូវ pop ទេ) — ប្តូរទៅ Home tab
                  widget.onGoHome!();
                }
              },
            ),
            title: Text(AppStrings.t('search_title')),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        hintText: AppStrings.t('search_placeholder'),
                        hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                        prefixIcon: const Icon(Icons.search, color: AppColors.textGrey, size: 20),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textGrey, size: 18),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              performSearch('');
                            });
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
                          Text(AppStrings.t('type_to_search'), style: const TextStyle(color: AppColors.textGrey)),
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
                          Text(AppStrings.t('no_results'), style: const TextStyle(color: AppColors.textGrey)),
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
      },
    );
  }
}