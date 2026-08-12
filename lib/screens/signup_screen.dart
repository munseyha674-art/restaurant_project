import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../core/app_colors.dart';
import '../widgets/gradient_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmError;

  bool _isValidEmail(String value) {
    final regex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(value);
  }

  Future<void> handleSignup() async {
    setState(() {
      nameError = null;
      emailError = null;
      passwordError = null;
      confirmError = null;

      if (nameController.text.trim().isEmpty) {
        nameError = 'សូមបញ្ចូលឈ្មោះ';
      }
      if (emailController.text.trim().isEmpty) {
        emailError = 'សូមបញ្ចូល Email';
      } else if (!_isValidEmail(emailController.text.trim())) {
        emailError = 'Email មិនត្រឹមត្រូវ';
      }
      if (passwordController.text.isEmpty) {
        passwordError = 'សូមបញ្ចូលលេខសម្ងាត់';
      } else if (passwordController.text.length < 6) {
        passwordError = 'លេខសម្ងាត់ត្រូវយ៉ាងតិច ៦ តួ';
      }
      if (confirmController.text != passwordController.text) {
        confirmError = 'លេខសម្ងាត់មិនត្រូវគ្នា';
      }
    });

    if (nameError != null || emailError != null || passwordError != null || confirmError != null) return;

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'បង្កើតគណនីថ្មី',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 6),
                const Text(
                  'ចុះឈ្មោះដើម្បីចាប់ផ្តើមកម្មង់ម្ហូប',
                  style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                ),
                const SizedBox(height: 28),

                _buildLabel('ឈ្មោះ'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: nameController,
                  hint: 'Seyha Mun',
                  icon: Icons.person_outline,
                  errorText: nameError,
                ),
                const SizedBox(height: 16),

                _buildLabel('Email'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: emailController,
                  hint: 'example@email.com',
                  icon: Icons.email_outlined,
                  errorText: emailError,
                ),
                const SizedBox(height: 16),

                _buildLabel('Password'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: passwordController,
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  errorText: passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textGrey,
                      size: 20,
                    ),
                    onPressed: () => setState(() => obscurePassword = !obscurePassword),
                  ),
                ),
                const SizedBox(height: 16),

                _buildLabel('បញ្ជាក់លេខសម្ងាត់'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: confirmController,
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  errorText: confirmError,
                ),
                const SizedBox(height: 28),

                GradientButton(label: 'ចុះឈ្មោះ', onPressed: handleSignup, isLoading: isLoading),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('មានគណនីរួចហើយ? ', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'ចូលគណនី',
                        style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: errorText != null ? AppColors.danger : AppColors.cardBorder, width: 1),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: AppColors.textDark, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
              prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(errorText, style: const TextStyle(color: AppColors.danger, fontSize: 12)),
        ],
      ],
    );
  }
}