import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';
import '../widgets/gradient_button.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  // ចាប់ផ្តើមដោយប្រើទិន្នន័យបច្ចុប្បន្នរបស់ user (dummy data ជាមួយ profile_screen)
  final TextEditingController nameController = TextEditingController(text: 'Seyha Mun');
  final TextEditingController emailController = TextEditingController(text: 'munseyha674@email.com');
  final TextEditingController phoneController = TextEditingController(text: '012 345 678');

  bool isSaving = false;

  Future<void> handleSave() async {
    setState(() => isSaving = true);

    // កន្លែងសម្រាប់ហៅ API ពិតប្រាកដនាពេលអនាគត — ឥឡូវសាកល្បងគ្រាន់តែរង់ចាំបន្តិច
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    setState(() => isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ព័ត៌មានត្រូវបានរក្សាទុក')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ការកំណត់គណនី'),
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('ឈ្មោះពេញ'),
            const SizedBox(height: 8),
            _buildTextField(controller: nameController, icon: Icons.person_outline),
            const SizedBox(height: AppSpacing.md),

            _buildLabel('អ៊ីមែល'),
            const SizedBox(height: 8),
            _buildTextField(controller: emailController, icon: Icons.email_outlined),
            const SizedBox(height: AppSpacing.md),

            _buildLabel('លេខទូរស័ព្ទ'),
            const SizedBox(height: 8),
            _buildTextField(controller: phoneController, icon: Icons.phone_outlined),
            const SizedBox(height: AppSpacing.xl),

            GradientButton(
              label: 'រក្សាទុក',
              onPressed: handleSave,
              isLoading: isSaving,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600));
  }

  Widget _buildTextField({required TextEditingController controller, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.button),
        boxShadow: AppShadows.card,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: AppColors.textDark, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        ),
      ),
    );
  }
}
