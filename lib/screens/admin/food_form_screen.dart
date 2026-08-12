import 'package:flutter/material.dart';
import '../../models/food.dart';
import '../../core/app_colors.dart';
import '../../core/app_style.dart';
import '../../widgets/gradient_button.dart';

// បើ existingFood == null -> កំពុងបន្ថែមថ្មី (Add)
// បើ existingFood != null -> កំពុងកែប្រែ (Edit)
class FoodFormScreen extends StatefulWidget {
  final Food? existingFood;

  const FoodFormScreen({super.key, this.existingFood});

  @override
  State<FoodFormScreen> createState() => _FoodFormScreenState();
}

class _FoodFormScreenState extends State<FoodFormScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;
  late String selectedImage;
  bool isSoldOut = false;

  // រូបភាពដែលមានស្រាប់ក្នុង app — ជ្រើសរើសពីក្នុងនេះ ជំនួសការ upload ពិតប្រាកដ
  final List<String> availableImages = [
    'assets/images/food1.png',
    'assets/images/food2.png',
    'assets/images/food3.png',
    'assets/images/food4.png',
    'assets/images/food5.png',
    'assets/images/food6.png',
  ];

  bool get isEditing => widget.existingFood != null;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.existingFood?.name ?? '');
    priceController = TextEditingController(text: widget.existingFood?.price.toString() ?? '');
    descController = TextEditingController(text: widget.existingFood?.description ?? '');
    selectedImage = widget.existingFood?.imageUrl ?? availableImages.first;
    isSoldOut = widget.existingFood?.isSoldOut ?? false;
  }

  void handleSave() {
    if (nameController.text.trim().isEmpty || priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('សូមបំពេញឈ្មោះ និងតម្លៃ')),
      );
      return;
    }

    final price = double.tryParse(priceController.text.trim());
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('តម្លៃមិនត្រឹមត្រូវ')),
      );
      return;
    }

    final result = Food(
      id: widget.existingFood?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      price: price,
      description: descController.text.trim(),
      imageUrl: selectedImage,
      isSoldOut: isSoldOut,
      rating: widget.existingFood?.rating ?? 4.5,
      ratingCount: widget.existingFood?.ratingCount ?? 0,
      restaurantId: widget.existingFood?.restaurantId ?? 1,
    );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'កែប្រែមុខម្ហូប' : 'បន្ថែមមុខម្ហូបថ្មី'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('រូបភាព', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: availableImages.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final img = availableImages[index];
                  final isSelected = selectedImage == img;
                  return GestureDetector(
                    onTap: () => setState(() => selectedImage = img),
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.surface,
                            child: const Icon(Icons.restaurant, color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            _label('ឈ្មោះមុខម្ហូប'),
            const SizedBox(height: 8),
            _textField(controller: nameController),
            const SizedBox(height: AppSpacing.md),

            _label('តម្លៃ (\$)'),
            const SizedBox(height: 8),
            _textField(controller: priceController, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
            const SizedBox(height: AppSpacing.md),

            _label('ការពិពណ៌នា'),
            const SizedBox(height: 8),
            _textField(controller: descController, maxLines: 3),
            const SizedBox(height: AppSpacing.md),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.button),
                boxShadow: AppShadows.card,
              ),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primary,
                title: const Text('អស់ស្តុក', style: TextStyle(color: AppColors.textDark, fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: const Text('អ្នកប្រើប្រាស់នឹងមិនអាចកម្មង់បានទេ', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                value: isSoldOut,
                onChanged: (value) => setState(() => isSoldOut = value),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            GradientButton(label: 'រក្សាទុក', onPressed: handleSave),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) =>
      Text(text, style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 13));

  Widget _textField({
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.button),
        boxShadow: AppShadows.card,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(color: AppColors.textDark, fontSize: 14),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        ),
      ),
    );
  }
}
