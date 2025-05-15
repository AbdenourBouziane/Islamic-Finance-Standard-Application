import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Islamic Finance Standards',
      'home': 'Home',
      'standardsExplorer': 'Standards Explorer',
      'interactiveTutorial': 'Interactive Tutorial',
      'glossary': 'Glossary',
      'customQuestion': 'Custom Question',
      'welcome': 'Welcome to Islamic Finance Standards Simplified',
      'welcomeDescription': 'This application helps you understand AAOIFI Financial Accounting Standards through simple explanations and practical examples.',
      'features': 'Features:',
      'feature1': 'Explore the five key standards: FAS 4, FAS 7, FAS 10, FAS 28, and FAS 32',
      'feature2': 'Learn through real-world examples and cases',
      'feature3': 'Interactive tutorials to test your understanding',
      'feature4': 'Multilingual support (English and Arabic)',
      'feature5': 'Ask custom questions about Islamic finance standards',
      'startExploring': 'Start Exploring',
      'selectStandard': 'Select a standard',
      'getExplanation': 'Get Explanation',
      'explanation': 'Explanation',
      'selectTutorial': 'Select a standard for tutorial',
      'enterSolution': 'Enter your solution',
      'checkAnswer': 'Check My Answer',
      'feedback': 'Feedback',
      'expertSolution': 'Expert Solution',
      'keyTerms': 'Key terms and concepts in Islamic finance',
      'askQuestion': 'Ask any question about Islamic finance standards',
      'yourQuestion': 'Your question',
      'getAnswer': 'Get Answer',
      'answer': 'Answer',
      'loading': 'Loading...',
      'error': 'An error occurred',
      'retry': 'Retry',
    },
    'ar': {
      'appTitle': 'معايير التمويل الإسلامي',
      'home': 'الصفحة الرئيسية',
      'standardsExplorer': 'مستكشف المعايير',
      'interactiveTutorial': 'الدروس التفاعلية',
      'glossary': 'المصطلحات',
      'customQuestion': 'سؤال مخصص',
      'welcome': 'مرحبًا بكم في تبسيط معايير التمويل الإسلامي',
      'welcomeDescription': 'يساعدك هذا التطبيق على فهم معايير المحاسبة المالية لهيئة المحاسبة والمراجعة للمؤسسات المالية الإسلامية من خلال شروحات بسيطة وأمثلة عملية.',
      'features': 'الميزات:',
      'feature1': 'استكشاف المعايير الخمسة الرئيسية: FAS 4، FAS 7، FAS 10، FAS 28، و FAS 32',
      'feature2': 'التعلم من خلال أمثلة وحالات من العالم الحقيقي',
      'feature3': 'دروس تفاعلية لاختبار فهمك',
      'feature4': 'دعم متعدد اللغات (الإنجليزية والعربية)',
      'feature5': 'اطرح أسئلة مخصصة حول معايير التمويل الإسلامي',
      'startExploring': 'ابدأ الاستكشاف',
      'selectStandard': 'اختر معيارًا',
      'getExplanation': 'الحصول على شرح',
      'explanation': 'الشرح',
      'selectTutorial': 'اختر معيارًا للدرس',
      'enterSolution': 'أدخل حلك',
      'checkAnswer': 'تحقق من إجابتي',
      'feedback': 'التعليق',
      'expertSolution': 'حل الخبير',
      'keyTerms': 'المصطلحات والمفاهيم الرئيسية في التمويل الإسلامي',
      'askQuestion': 'اطرح أي سؤال حول معايير التمويل الإسلامي',
      'yourQuestion': 'سؤالك',
      'getAnswer': 'الحصول على إجابة',
      'answer': 'الإجابة',
      'loading': 'جاري التحميل...',
      'error': 'حدث خطأ',
      'retry': 'إعادة المحاولة',
    },
  };
  
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }
  
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
