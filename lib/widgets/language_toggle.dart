import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return IconButton(
      icon: Text(
        languageProvider.isEnglish ? 'AR' : 'EN',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        languageProvider.toggleLanguage();
      },
      tooltip: languageProvider.isEnglish ? 'Switch to Arabic' : 'Switch to English',
    );
  }
}
