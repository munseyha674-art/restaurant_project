import 'package:flutter/material.dart';
import 'package:restaurant_project/screens/search_screen.dart';
import 'dart:async';
import '../data/dummy_data.dart';
import '../widgets/food_card.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';
import 'food_detail_screen.dart';
import 'all_food_screen.dart';
import 'restaurant_list_screen.dart';
import 'category_food_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController bannerController = PageController();
  int currentBanner = 0;
  Timer? bannerTimer;

  @override
  void initState() {
    super.initState();
    startAutoSlide();
  }

  void startAutoSlide() {
    bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentBanner < dummyFoodList.length - 1) {
        currentBanner++;
      } else {
        currentBanner = 0;
      }
      bannerController.animateToPage(
        currentBanner,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    bannerTimer?.cancel();
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppStrings.t('hello')}, Seyha 👋',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          boxShadow: AppShadows.card,
                        ),
                        child: const Icon(Icons.notifications_none, color: AppColors.textDark, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Search bar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadius.button),
                        boxShadow: AppShadows.card,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.textGrey, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(AppStrings.t('search_hint'), style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  Text(
                    AppStrings.t('popular_restaurants'),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Auto-sliding banner — ចុចដើម្បីមើលភោជនីយដ្ឋានទាំងអស់
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RestaurantListScreen()));
                    },
                    child: SizedBox(
                      height: 140,
                      child: PageView.builder(
                        controller: bannerController,
                        itemCount: dummyFoodList.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentBanner = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final food = dummyFoodList[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppRadius.card),
                              boxShadow: AppShadows.card,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppRadius.card),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    food.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.surface,
                                        child: const Icon(Icons.restaurant, size: 40, color: AppColors.primary),
                                      );
                                    },
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            food.localizedName(lang),
                                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, color: Colors.amber, size: 14),
                                              const SizedBox(width: 4),
                                              Text(
                                                '\$${food.price.toStringAsFixed(2)}',
                                                style: const TextStyle(color: Colors.white, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Dot indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(dummyFoodList.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: currentBanner == index ? 18 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: currentBanner == index ? AppColors.primary : AppColors.textGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  Text(
                    AppStrings.t('categories'),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _categoryIcon(context, '🍽️', AppStrings.t('food_category'), 'food'),
                      _categoryIcon(context, '🥤', AppStrings.t('drink_category'), 'drink'),
                      _categoryIcon(context, '🍨', AppStrings.t('dessert'), 'dessert'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // "ណែនាំសម្រាប់អ្នក" header + arrow to see all
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.t('recommended'),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllFoodScreen()));
                        },
                        child: Row(
                          children: [
                            Text(AppStrings.t('view_all'), style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 2),
                            const Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _categoryIcon(BuildContext context, String emoji, String label, String categoryKey) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryFoodScreen(category: categoryKey, categoryLabel: label),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              boxShadow: AppShadows.card,
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 26)),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
        ],
      ),
    );
  }
}
