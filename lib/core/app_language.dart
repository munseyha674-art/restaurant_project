import 'package:flutter/foundation.dart';

enum AppLanguage { km, en }

class LanguageService {
  static final LanguageService instance = LanguageService._internal();
  LanguageService._internal();

  final ValueNotifier<AppLanguage> current = ValueNotifier<AppLanguage>(AppLanguage.km);

  void toggle() {
    current.value = current.value == AppLanguage.km ? AppLanguage.en : AppLanguage.km;
  }

  void setLanguage(AppLanguage lang) {
    current.value = lang;
  }
}
