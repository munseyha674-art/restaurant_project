import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'signup_screen.dart';
import '../core/app_colors.dart';
import '../core/app_language.dart';
import '../core/app_strings.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;
  String? emailError;
  String? passwordError;

  bool _isValidEmail(String value) {
    final regex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(value);
  }

  Future<void> handleLogin() async {
    setState(() {
      emailError = null;
      passwordError = null;

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
    });

    if (emailError != null || passwordError != null) return;

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
    return ValueListenableBuilder<AppLanguage>(
      valueListenable: LanguageService.instance.current,
      builder: (context, lang, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.restaurant, color: Colors.white, size: 32),
                      ),

                      Text(
                        AppStrings.t('welcome_back'),
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppStrings.t('login_subtitle'),
                        style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
                      ),
                      const SizedBox(height: 32),

                      _buildLabel(AppStrings.t('email')),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: emailController,
                        hint: 'example@email.com',
                        icon: Icons.email_outlined,
                        errorText: emailError,
                      ),
                      const SizedBox(height: 18),

                      _buildLabel(AppStrings.t('password')),
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
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: AppColors.background,
                                title: const Text('ភ្លេចលេខសម្ងាត់'),
                                content: const Text('មុខងារនេះនឹងមកដល់ឆាប់ៗនេះ'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('យល់ព្រម'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            AppStrings.t('forgot_password'),
                            style: const TextStyle(color: AppColors.primary, fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      GradientButton(label: AppStrings.t('login_button'), onPressed: handleLogin, isLoading: isLoading),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.t('no_account'), style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                            },
                            child: Text(
                              AppStrings.t('signup'),
                              style: const TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Center(
                        child: TextButton.icon(
                          onPressed: () => LanguageService.instance.toggle(),
                          icon: const Icon(Icons.language, size: 18, color: AppColors.textGrey),
                          label: Text(
                            lang == AppLanguage.km ? 'English' : 'ភាសាខ្មែរ',
                            style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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