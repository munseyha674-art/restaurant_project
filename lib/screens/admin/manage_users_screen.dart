import 'package:flutter/material.dart';
import '../../data/dummy_users.dart';
import '../../models/app_user.dart';
import '../../core/app_colors.dart';
import '../../core/app_style.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  void _confirmDelete(AppUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text('លុបអ្នកប្រើប្រាស់?'),
        content: Text('តើអ្នកចង់លុប ${user.name} មែនទេ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('បោះបង់'),
          ),
          TextButton(
            onPressed: () {
              setState(() => dummyUsers.removeWhere((u) => u.id == user.id));
              Navigator.pop(context);
            },
            child: const Text('លុប', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  void _editRole(AppUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text('សិទ្ធិរបស់ ${user.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('User'),
              value: 'user',
              groupValue: user.role,
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() => user.role = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Admin'),
              value: 'admin',
              groupValue: user.role,
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() => user.role = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('គ្រប់គ្រងអ្នកប្រើប្រាស់'),
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: dummyUsers.length,
        itemBuilder: (context, index) {
          final user = dummyUsers[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.card),
              boxShadow: AppShadows.card,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.surface,
                  child: Icon(Icons.person, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(user.email, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: user.role == 'admin' ? AppColors.primary.withOpacity(0.12) : AppColors.surface,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user.role,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: user.role == 'admin' ? AppColors.primary : AppColors.textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textGrey),
                  onPressed: () => _editRole(user),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.danger),
                  onPressed: () => _confirmDelete(user),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
