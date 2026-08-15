import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../data/cart_service.dart';
import '../core/app_colors.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  int cartRefreshKey = 0;

  void goToHomeTab() {
    setState(() => currentIndex = 0);
  }

  List<Widget> get pages => [
    const HomeScreen(),
    SearchScreen(onGoHome: goToHomeTab),
    CartScreen(key: ValueKey(cartRefreshKey)),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                if (index == 2) {
                  cartRefreshKey++;
                }
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppStrings.t('nav_home')),
              BottomNavigationBarItem(icon: const Icon(Icons.search), label: AppStrings.t('nav_search')),
              BottomNavigationBarItem(
                icon: ValueListenableBuilder<int>(
                  valueListenable: CartService.instance.itemCount,
                  builder: (context, count, child) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart),
                        if (count > 0)
                          Positioned(
                            right: -8,
                            top: -4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.danger,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(minWidth: 16),
                              child: Text(
                                '$count',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                label: AppStrings.t('nav_cart'),
              ),
              BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppStrings.t('nav_profile')),
            ],
          ),
        );
      },
    );
  }
}