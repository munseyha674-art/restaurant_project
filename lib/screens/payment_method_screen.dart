import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_style.dart';

class PaymentMethodScreen extends StatefulWidget {
  // ជម្រើសបច្ចុប្បន្ន (ដែលបានជ្រើសរើសពីមុន) បញ្ជូនចូលមក ដើម្បីអោយ radio ដឹងថាមួយណាគួរជ្រើសមុន
  final String currentMethod;

  const PaymentMethodScreen({super.key, required this.currentMethod});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.currentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('វិធីបង់ប្រាក់'),
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _paymentOption(
              icon: Icons.money,
              title: 'បង់ប្រាក់ពេលទទួលទំនិញ',
              subtitle: 'Cash on Delivery (COD)',
              value: 'cod',
            ),
            const SizedBox(height: 10),
            _paymentOption(
              icon: Icons.credit_card,
              title: 'បង់ប្រាក់អនឡាញ',
              subtitle: 'ATM / Credit Card / KHQR',
              value: 'online',
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final bool isSelected = selected == value;
    return GestureDetector(
      onTap: () {
        setState(() => selected = value);
        // ត្រឡប់ទៅ checkout វិញភ្លាមៗ ជាមួយនឹងជម្រើសដែលបានចុច
        Navigator.pop(context, value);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
