import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/standard.dart';
import '../models/example.dart';
import '../models/glossary_term.dart';

class AppState extends ChangeNotifier {
  bool _isEnglish = true;
  bool get isEnglish => _isEnglish;

  List<Standard> _standards = [];
  List<Standard> get standards => _standards;

  List<Example> _examples = [];
  List<Example> get examples => _examples;

  List<GlossaryTerm> _glossaryTerms = [];
  List<GlossaryTerm> get glossaryTerms => _glossaryTerms;

  String _selectedStandardId = '';
  String get selectedStandardId => _selectedStandardId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _apiBaseUrl = 'http://10.0.2.2:8000'; // For Android emulator
  // Use 'http://localhost:8000' for iOS simulator or web

  AppState() {
    _initializeData();
  }

  void _initializeData() async {
    await fetchStandards();
    await fetchExamples();
    await fetchGlossaryTerms();
    
    if (_standards.isNotEmpty) {
      _selectedStandardId = _standards[0].id;
    }
  }

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  void setSelectedStandard(String id) {
    _selectedStandardId = id;
    notifyListeners();
  }

  Future<void> fetchStandards() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$_apiBaseUrl/api/standards'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _standards = data.map((item) => Standard.fromJson(item)).toList();
      } else {
        // If server returns an error, use mock data
        _standards = _getMockStandards();
      }
    } catch (e) {
      // If there's an error (like no connection), use mock data
      _standards = _getMockStandards();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchExamples() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$_apiBaseUrl/api/examples'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _examples = data.map((item) => Example.fromJson(item)).toList();
      } else {
        // If server returns an error, use mock data
        _examples = _getMockExamples();
      }
    } catch (e) {
      // If there's an error, use mock data
      _examples = _getMockExamples();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchGlossaryTerms() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$_apiBaseUrl/api/glossary'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _glossaryTerms = data.map((item) => GlossaryTerm.fromJson(item)).toList();
      } else {
        // If server returns an error, use mock data
        _glossaryTerms = _getMockGlossaryTerms();
      }
    } catch (e) {
      // If there's an error, use mock data
      _glossaryTerms = _getMockGlossaryTerms();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String> getExplanation(String standardId, String scenario) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/api/explanation'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'standard_id': standardId,
          'scenario': scenario,
          'language': isEnglish ? 'English' : 'Arabic',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['explanation'];
      } else {
        return isEnglish 
          ? 'Failed to get explanation. Please try again later.'
          : 'فشل في الحصول على الشرح. يرجى المحاولة مرة أخرى لاحقًا.';
      }
    } catch (e) {
      return isEnglish 
        ? 'Network error. Please check your connection.'
        : 'خطأ في الشبكة. يرجى التحقق من اتصالك.';
    }
  }

  Future<Map<String, dynamic>> getFeedback(String standardId, String userSolution) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/api/feedback'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'standard_id': standardId,
          'user_solution': userSolution,
          'language': isEnglish ? 'English' : 'Arabic',
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'feedback': isEnglish 
            ? 'Failed to get feedback. Please try again later.'
            : 'فشل في الحصول على التعليقات. يرجى المحاولة مرة أخرى لاحقًا.',
          'expert_solution': '',
        };
      }
    } catch (e) {
      return {
        'feedback': isEnglish 
          ? 'Network error. Please check your connection.'
          : 'خطأ في الشبكة. يرجى التحقق من اتصالك.',
        'expert_solution': '',
      };
    }
  }

  Future<String> askCustomQuestion(String question) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/api/ask'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'question': question,
          'language': isEnglish ? 'English' : 'Arabic',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['answer'];
      } else {
        return isEnglish 
          ? 'Failed to get answer. Please try again later.'
          : 'فشل في الحصول على الإجابة. يرجى المحاولة مرة أخرى لاحقًا.';
      }
    } catch (e) {
      return isEnglish 
        ? 'Network error. Please check your connection.'
        : 'خطأ في الشبكة. يرجى التحقق من اتصالك.';
    }
  }

  // Mock data methods for offline use
  List<Standard> _getMockStandards() {
    return [
      Standard(
        id: 'FAS 4',
        titleEn: 'Currency Translation',
        titleAr: 'ترجمة العملات',
        descriptionEn: 'Standard for recording foreign currency transactions and translating financial statements.',
        descriptionAr: 'معيار لتسجيل معاملات العملات الأجنبية وترجمة البيانات المالية.',
      ),
      Standard(
        id: 'FAS 7',
        titleEn: 'Investments in Real Estate',
        titleAr: 'الاستثمارات العقارية',
        descriptionEn: 'Standard for accounting for investments in properties for rental or capital appreciation.',
        descriptionAr: 'معيار محاسبة الاستثمارات في العقارات للتأجير أو زيادة رأس المال.',
      ),
      Standard(
        id: 'FAS 10',
        titleEn: 'Istisna\'a and Parallel Istisna\'a',
        titleAr: 'الاستصناع والاستصناع الموازي',
        descriptionEn: 'Standard for manufacturing contracts where payment is made in installments.',
        descriptionAr: 'معيار لعقود التصنيع حيث يتم الدفع على أقساط.',
      ),
      Standard(
        id: 'FAS 28',
        titleEn: 'Ijarah and Ijarah Muntahia Bittamleek',
        titleAr: 'الإجارة والإجارة المنتهية بالتمليك',
        descriptionEn: 'Standard for lease agreements and leases ending with ownership transfer.',
        descriptionAr: 'معيار لاتفاقيات الإيجار والإيجارات المنتهية بنقل الملكية.',
      ),
      Standard(
        id: 'FAS 32',
        titleEn: 'Investment Agency (Al-Wakala Bi Al-Istithmar)',
        titleAr: 'وكالة الاستثمار (الوكالة بالاستثمار)',
        descriptionEn: 'Standard for investment agency relationships between investors and agents.',
        descriptionAr: 'معيار لعلاقات وكالة الاستثمار بين المستثمرين والوكلاء.',
      ),
    ];
  }

  List<Example> _getMockExamples() {
    return [
      Example(
        standardId: 'FAS 4',
        titleEn: 'Converting USD to EUR for international trade',
        titleAr: 'تحويل الدولار الأمريكي إلى اليورو للتجارة الدولية',
        scenarioEn: 'Al Baraka Bank needs to record a transaction where they purchased machinery from a European supplier:\n- Purchase price: €500,000\n- Exchange rate on purchase date: 1 EUR = 1.10 USD\n- Exchange rate on payment date (30 days later): 1 EUR = 1.12 USD\nHow should this be recorded in the books?',
        scenarioAr: 'يحتاج بنك البركة إلى تسجيل معاملة شراء آلات من مورد أوروبي:\n- سعر الشراء: 500,000 يورو\n- سعر الصرف في تاريخ الشراء: 1 يورو = 1.10 دولار أمريكي\n- سعر الصرف في تاريخ الدفع (بعد 30 يومًا): 1 يورو = 1.12 دولار أمريكي\nكيف يجب تسجيل هذا في الدفاتر؟',
      ),
      Example(
        standardId: 'FAS 7',
        titleEn: 'Acquiring an office building for rental',
        titleAr: 'الاستحواذ على مبنى مكتبي للتأجير',
        scenarioEn: 'Islamic Finance House purchased a commercial building:\n- Purchase price: \$5,000,000\n- Legal fees: \$50,000\n- Building improvements: \$200,000\n- Expected rental income: \$400,000 per year\nHow should this investment be recorded and measured?',
        scenarioAr: 'اشترى بيت التمويل الإسلامي مبنى تجاري:\n- سعر الشراء: 5,000,000 دولار\n- الرسوم القانونية: 50,000 دولار\n- تحسينات المبنى: 200,000 دولار\n- الدخل المتوقع من الإيجار: 400,000 دولار سنويًا\nكيف يجب تسجيل وقياس هذا الاستثمار؟',
      ),
      Example(
        standardId: 'FAS 10',
        titleEn: 'Manufacturing contract for custom equipment',
        titleAr: 'عقد تصنيع لمعدات مخصصة',
        scenarioEn: 'Al Salam Bank entered into an Istisna\'a contract with a manufacturer:\n- Contract value: \$1,000,000 for custom manufacturing equipment\n- Payment schedule: 30% upfront, 30% halfway, 40% upon delivery\n- Manufacturing period: 8 months\nHow should the bank record this transaction?',
        scenarioAr: 'دخل بنك السلام في عقد استصناع مع مصنّع:\n- قيمة العقد: 1,000,000 دولار لمعدات تصنيع مخصصة\n- جدول الدفع: 30٪ مقدمًا، 30٪ في المنتصف، 40٪ عند التسليم\n- فترة التصنيع: 8 أشهر\nكيف يجب على البنك تسجيل هذه المعاملة؟',
      ),
      Example(
        standardId: 'FAS 28',
        titleEn: 'Leasing equipment with ownership transfer',
        titleAr: 'تأجير معدات مع نقل الملكية',
        scenarioEn: 'Alpha Islamic Bank entered into an Ijarah MBT for a generator:\n- Generator cost: \$450,000\n- Import tax and freight: \$42,000\n- Lease term: 2 years\n- Annual rental: \$300,000\n- Purchase option at end: \$3,000\nHow should Alpha Bank record this transaction?',
        scenarioAr: 'دخل بنك ألفا الإسلامي في إجارة منتهية بالتمليك لمولد كهربائي:\n- تكلفة المولد: 450,000 دولار\n- ضريبة الاستيراد والشحن: 42,000 دولار\n- مدة الإيجار: سنتان\n- الإيجار السنوي: 300,000 دولار\n- خيار الشراء في النهاية: 3,000 دولار\nكيف يجب على بنك ألفا تسجيل هذه المعاملة؟',
      ),
      Example(
        standardId: 'FAS 32',
        titleEn: 'Investment agency relationship',
        titleAr: 'علاقة وكالة استثمار',
        scenarioEn: 'Qatar Islamic Bank accepted \$10M from investors on Wakala basis:\n- Expected profit rate: 5% annually\n- Bank\'s agency fee: 20% of profits above 5%\n- Investment term: 1 year\n- Actual return achieved: 7%\nHow should this be accounted for?',
        scenarioAr: 'قبل بنك قطر الإسلامي 10 مليون دولار من المستثمرين على أساس الوكالة:\n- معدل الربح المتوقع: 5٪ سنويًا\n- رسوم وكالة البنك: 20٪ من الأرباح فوق 5٪\n- مدة الاستثمار: سنة واحدة\n- العائد الفعلي المحقق: 7٪\nكيف يجب المحاسبة عن ذلك؟',
      ),
    ];
  }

  List<GlossaryTerm> _getMockGlossaryTerms() {
    return [
      GlossaryTerm(
        term: 'Ijarah',
        definitionEn: 'A lease contract where one party transfers the right to use an asset to another party for an agreed period at an agreed consideration.',
        definitionAr: 'عقد إيجار حيث ينقل طرف حق استخدام أصل إلى طرف آخر لفترة متفق عليها بمقابل متفق عليه.',
      ),
      GlossaryTerm(
        term: 'Murabaha',
        definitionEn: 'A sales contract where the seller expressly mentions the cost incurred on the sold commodity and sells it to another person by adding some profit.',
        definitionAr: 'عقد بيع حيث يذكر البائع صراحةً التكلفة التي تكبدها على السلعة المباعة ويبيعها لشخص آخر بإضافة بعض الربح.',
      ),
      GlossaryTerm(
        term: 'Wakala',
        definitionEn: 'An agency contract where one party appoints another party to act on their behalf for a specific task.',
        definitionAr: 'عقد وكالة حيث يعين طرف طرفًا آخر للتصرف نيابة عنه لمهمة محددة.',
      ),
      GlossaryTerm(
        term: 'Istisna\'a',
        definitionEn: 'A contract of sale where a commodity is transacted before it comes into existence, requiring the manufacturer to make it with payment from the buyer either in advance or by installments.',
        definitionAr: 'عقد بيع حيث يتم تداول سلعة قبل وجودها، مما يتطلب من المصنع صنعها مع دفع المشتري إما مقدمًا أو على أقساط.',
      ),
      GlossaryTerm(
        term: 'Sukuk',
        definitionEn: 'Islamic financial certificates, similar to bonds, that comply with Shariah law.',
        definitionAr: 'شهادات مالية إسلامية، مشابهة للسندات، تتوافق مع الشريعة الإسلامية.',
      ),
    ];
  }
}
