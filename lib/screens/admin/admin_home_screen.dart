import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_style.dart';
import 'manage_users_screen.dart';
import 'manage_menu_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ផ្ទាំងគ្រប់គ្រង (Admin)'),
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            _adminTile(
              context,
              icon: Icons.people_outline,
              title: 'គ្រប់គ្រងអ្នកប្រើប្រាស់',
              subtitle: 'Manage Users',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageUsersScreen()));
              },
            ),
            const SizedBox(height: 12),
            _adminTile(
              context,
              icon: Icons.restaurant_menu,
              title: 'គ្រប់គ្រងមុខម្ហូប',
              subtitle: 'Manage Menu',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageMenuScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _adminTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
