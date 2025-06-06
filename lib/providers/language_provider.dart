import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en', '');

  Locale get currentLocale => _currentLocale;

  void setLocale(Locale locale) {
    if (locale.languageCode != _currentLocale.languageCode) {
      _currentLocale = locale;
      notifyListeners();
    }
  }

  void toggleLanguage() {
    _currentLocale = _currentLocale.languageCode == 'en'
        ? const Locale('ar', '')
        : const Locale('en', '');
    notifyListeners();
  }

  bool get isEnglish => _currentLocale.languageCode == 'en';
}
