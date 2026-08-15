import 'app_language.dart';
import '../models/food.dart';

// មជ្ឈមណ្ឌលបកប្រែពាក្យទាំងអស់ — បន្ថែម key ថ្មីនៅទីនេះ ពេលបន្ថែមអេក្រង់ថ្មី
class AppStrings {
  static final Map<String, Map<AppLanguage, String>> _t = {
    // --- Login ---
    'welcome_back': {AppLanguage.km: 'សូមស្វាគមន៍មកវិញ', AppLanguage.en: 'Welcome Back'},
    'login_subtitle': {AppLanguage.km: 'ចូលគណនីដើម្បីបន្តការកម្មង់', AppLanguage.en: 'Log in to continue ordering'},
    'email': {AppLanguage.km: 'Email', AppLanguage.en: 'Email'},
    'password': {AppLanguage.km: 'Password', AppLanguage.en: 'Password'},
    'forgot_password': {AppLanguage.km: 'ភ្លេចលេខសម្ងាត់?', AppLanguage.en: 'Forgot password?'},
    'login_button': {AppLanguage.km: 'ចូលគណនី', AppLanguage.en: 'Log In'},
    'no_account': {AppLanguage.km: 'មិនទាន់មានគណនី? ', AppLanguage.en: "Don't have an account? "},
    'signup': {AppLanguage.km: 'ចុះឈ្មោះ', AppLanguage.en: 'Sign Up'},

    // --- Home ---
    'hello': {AppLanguage.km: 'សួស្តី', AppLanguage.en: 'Hello'},
    'search_hint': {AppLanguage.km: 'ស្វែងរកភោជនីយដ្ឋាន ឬម្ហូប', AppLanguage.en: 'Search restaurants or food'},
    'popular_restaurants': {AppLanguage.km: 'ភោជនីយដ្ឋានពេញនិយម', AppLanguage.en: 'Popular Restaurants'},
    'categories': {AppLanguage.km: 'ប្រភេទម្ហូប', AppLanguage.en: 'Categories'},
    'recommended': {AppLanguage.km: 'ណែនាំសម្រាប់អ្នក', AppLanguage.en: 'Recommended for You'},
    'view_all': {AppLanguage.km: 'មើលទាំងអស់', AppLanguage.en: 'View All'},
    'pizza': {AppLanguage.km: 'ភីហ្សា', AppLanguage.en: 'Pizza'},
    'burger': {AppLanguage.km: 'ប៊ឺហ្គឺរ', AppLanguage.en: 'Burger'},
    'asian': {AppLanguage.km: 'អាស៊ី', AppLanguage.en: 'Asian'},
    'dessert': {AppLanguage.km: 'បង្អែម', AppLanguage.en: 'Dessert'},
    'food_category': {AppLanguage.km: 'ម្ហូប', AppLanguage.en: 'Food'},
    'drink_category': {AppLanguage.km: 'ភេសជ្ជៈ', AppLanguage.en: 'Drink'},

    // --- Bottom nav ---
    'nav_home': {AppLanguage.km: 'ទំព័រដើម', AppLanguage.en: 'Home'},
    'nav_search': {AppLanguage.km: 'ស្វែងរក', AppLanguage.en: 'Search'},
    'nav_cart': {AppLanguage.km: 'កន្ត្រក', AppLanguage.en: 'Cart'},
    'nav_profile': {AppLanguage.km: 'ប្រវត្តិរូប', AppLanguage.en: 'Profile'},

    // --- Profile ---
    'personal_information':{AppLanguage.km: 'ព័ត៌មានផ្ទាល់ខ្លួន', AppLanguage.en: 'Personal Information'},
    'account_settings': {AppLanguage.km: 'ការកំណត់គណនី', AppLanguage.en: 'Account Settings'},
    'order_history': {AppLanguage.km: 'ប្រវត្តិការកម្មង់', AppLanguage.en: 'Order History'},
    'delivery_address': {AppLanguage.km: 'អាសយដ្ឋានដឹកជញ្ជូន', AppLanguage.en: 'Delivery Address'},
    'notifications': {AppLanguage.km: 'ការជូនដំណឹង', AppLanguage.en: 'Notifications'},
    'admin_panel': {AppLanguage.km: 'ផ្ទាំងគ្រប់គ្រង (Admin)', AppLanguage.en: 'Admin Panel'},
    'language': {AppLanguage.km: 'ភាសា', AppLanguage.en: 'Language'},
    'logout': {AppLanguage.km: 'ចាកចេញ', AppLanguage.en: 'Log Out'},

    // --- Cart / Checkout ---
    'your_cart': {AppLanguage.km: 'កន្ត្រករបស់អ្នក', AppLanguage.en: 'Your Cart'},
    'cart_empty': {AppLanguage.km: 'កន្ត្រកទំនិញនៅទទេ', AppLanguage.en: 'Your cart is empty'},
    'total': {AppLanguage.km: 'សរុប', AppLanguage.en: 'Total'},
    'checkout': {AppLanguage.km: 'បញ្ជាទិញ', AppLanguage.en: 'Checkout'},
    'order_summary': {AppLanguage.km: 'សេចក្តីសង្ខេបការកម្មង់', AppLanguage.en: 'Order Summary'},
    'payment_method': {AppLanguage.km: 'វិធីបង់ប្រាក់', AppLanguage.en: 'Payment Method'},
    'grand_total': {AppLanguage.km: 'តម្លៃសរុប', AppLanguage.en: 'Grand Total'},
    'confirm_order': {AppLanguage.km: 'បញ្ជាក់ការទិញ', AppLanguage.en: 'Confirm Order'},
    'add_to_cart': {AppLanguage.km: 'បន្ថែមចូល Cart', AppLanguage.en: 'Add to Cart'},
    'sold_out': {AppLanguage.km: 'អស់ស្តុក', AppLanguage.en: 'Sold Out'},
    'quantity': {AppLanguage.km: 'ចំនួន', AppLanguage.en: 'Quantity'},
    'description': {AppLanguage.km: 'ការពិពណ៌នា', AppLanguage.en: 'Description'},
    'rate_this_food': {AppLanguage.km: 'វាយតម្លៃម្ហូបនេះ', AppLanguage.en: 'Rate this food'},
    'ratings_label': {AppLanguage.km: 'ការវាយតម្លៃ', AppLanguage.en: 'ratings'},
    'thanks_rating': {AppLanguage.km: 'អរគុណសម្រាប់ការវាយតម្លៃ!', AppLanguage.en: 'Thanks for rating!'},
    'sold_out_cannot_order': {AppLanguage.km: 'អស់ស្តុក — មិនអាចកម្មង់បានទេ', AppLanguage.en: 'Sold out — cannot order'},
    'added_to_cart_suffix': {AppLanguage.km: ' ត្រូវបានបន្ថែមចូល Cart', AppLanguage.en: ' added to cart'},
    'delivery_address_label': {AppLanguage.km: 'អាសយដ្ឋានដឹកជញ្ជូន', AppLanguage.en: 'Delivery Address'},
    'promo_code': {AppLanguage.km: 'លេខកូដបញ្ចុះតម្លៃ', AppLanguage.en: 'Promo Code'},
    'apply': {AppLanguage.km: 'អនុវត្ត', AppLanguage.en: 'Apply'},
    'pay_cod': {AppLanguage.km: 'បង់ប្រាក់ពេលទទួលទំនិញ', AppLanguage.en: 'Cash on Delivery'},
    'pay_online': {AppLanguage.km: 'បង់ប្រាក់អនឡាញ', AppLanguage.en: 'Pay Online'},
    'success_title': {AppLanguage.km: 'ជោគជ័យ!', AppLanguage.en: 'Success!'},
    'order_received_cod': {AppLanguage.km: 'ការកម្មង់របស់អ្នកត្រូវបានទទួល សូមរៀបចំប្រាក់សម្រាប់បង់ពេលទទួលទំនិញ', AppLanguage.en: 'Your order has been received. Please prepare cash for delivery.'},
    'order_received_online': {AppLanguage.km: 'ការកម្មង់របស់អ្នកត្រូវបានទទួល សូមបញ្ចប់ការបង់ប្រាក់អនឡាញ', AppLanguage.en: 'Your order has been received. Please complete online payment.'},
    'ok': {AppLanguage.km: 'OK', AppLanguage.en: 'OK'},
    'no_orders_yet': {AppLanguage.km: 'មិនទាន់មានការកម្មង់', AppLanguage.en: 'No orders yet'},
    'search_title': {AppLanguage.km: 'ស្វែងរក', AppLanguage.en: 'Search'},
    'search_placeholder': {AppLanguage.km: 'ស្វែងរកម្ហូប...', AppLanguage.en: 'Search for food...'},
    'type_to_search': {AppLanguage.km: 'វាយឈ្មោះម្ហូបដើម្បីស្វែងរក', AppLanguage.en: 'Type a food name to search'},
    'no_results': {AppLanguage.km: 'រកមិនឃើញលទ្ធផល', AppLanguage.en: 'No results found'},
  };

  static String t(String key) {
    final lang = LanguageService.instance.current.value;
    return _t[key]?[lang] ?? key;
  }
}

// ជួយបកប្រែឈ្មោះ/ការពិពណ៌នារបស់ម្ហូបនីមួយៗ (data ខ្លួនឯង មិនមែន UI label ទេ)
extension FoodLocalization on Food {
  String localizedName(AppLanguage lang) {
    if (lang == AppLanguage.en && nameEn.isNotEmpty) return nameEn;
    return name;
  }

  String localizedDescription(AppLanguage lang) {
    if (lang == AppLanguage.en && descriptionEn.isNotEmpty) return descriptionEn;
    return description;
  }
}