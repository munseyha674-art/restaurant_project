import 'package:flutter/material.dart';
import 'order_history_screen.dart';
import 'account_settings_screen.dart';
import 'admin/admin_home_screen.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 46,
                          backgroundColor: AppColors.surface,
                          child: Icon(Icons.person, size: 46, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Seyha Mun',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const Text(
                        'munseyha674@email.com',
                        style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // ប្តូរភាសា — ចុចដើម្បីប្តូរ ខ្មែរ <-> English
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadius.button),
                    boxShadow: AppShadows.card,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.language, color: AppColors.primary),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(AppStrings.t('language'), style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500)),
                      ),
                      _langChip('ខ្មែរ', AppLanguage.km, lang),
                      const SizedBox(width: 6),
                      _langChip('EN', AppLanguage.en, lang),
                    ],
                  ),
                ),

                _menuTile(
                  icon: Icons.settings_outlined,
                  label: AppStrings.t('account_settings'),
                  onTap: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSettingsScreen()));
                  },
                ),
                _menuTile(
                  icon: Icons.receipt_long,
                  label: AppStrings.t('order_history'),
                  onTap: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
                  },
                ),
                _menuTile(icon: Icons.location_on, label: AppStrings.t('delivery_address'), onTap: (context) {}),
                _menuTile(icon: Icons.notifications_none, label: AppStrings.t('notifications'), onTap: (context) {}),
                _menuTile(
                  icon: Icons.admin_panel_settings_outlined,
                  label: AppStrings.t('admin_panel'),
                  onTap: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminHomeScreen()));
                  },
                ),
                _menuTile(icon: Icons.logout, label: AppStrings.t('logout'), onTap: (context) {}, isDanger: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _langChip(String label, AppLanguage value, AppLanguage current) {
    final bool isActive = value == current;
    return GestureDetector(
      onTap: () => LanguageService.instance.setLanguage(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.textGrey,
          ),
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String label,
    required void Function(BuildContext) onTap,
    bool isDanger = false,
  }) {
    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.button),
          boxShadow: AppShadows.card,
        ),
        child: ListTile(
          leading: Icon(icon, color: isDanger ? AppColors.danger : AppColors.primary),
          title: Text(
            label,
            style: TextStyle(color: isDanger ? AppColors.danger : AppColors.textDark, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
          onTap: () => onTap(context),
        ),
      ),
    );
  }
}