import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/standard.dart';
import '../models/example.dart';
import '../models/glossary_term.dart';
import '../services/api_service.dart';

class StandardProvider extends ChangeNotifier {
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

  final ApiService _apiService = ApiService();

  StandardProvider() {
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isEnglish = prefs.getBool('isEnglish') ?? true;
      notifyListeners();
    } catch (e) {
      // Default to English if there's an error
      _isEnglish = true;
    }
  }

  Future<void> _saveLanguagePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isEnglish', _isEnglish);
    } catch (e) {
      // Ignore errors when saving preferences
    }
  }

  Future<void> initializeData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await fetchStandards();
      await fetchExamples();
      await fetchGlossaryTerms();
      
      if (_standards.isNotEmpty) {
        _selectedStandardId = _standards[0].id;
      }
    } catch (e) {
      // Handle initialization errors
      print('Error initializing data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    _saveLanguagePreference();
    notifyListeners();
  }

  void setSelectedStandard(String id) {
    _selectedStandardId = id;
    notifyListeners();
  }

  Future<void> fetchStandards() async {
    try {
      final standards = await _apiService.getStandards();
      _standards = standards;
    } catch (e) {
      print('Error in fetchStandards: $e');
    }
  }

  Future<void> fetchExamples() async {
    try {
      final examples = await _apiService.getExamples();
      _examples = examples;
    } catch (e) {
      print('Error in fetchExamples: $e');
    }
  }

  Future<void> fetchGlossaryTerms() async {
    try {
      final glossaryTerms = await _apiService.getGlossaryTerms();
      _glossaryTerms = glossaryTerms;
    } catch (e) {
      print('Error in fetchGlossaryTerms: $e');
    }
  }

  Future<String> getExplanation(String standardId, String scenario) async {
    try {
      return await _apiService.getExplanation(
        standardId,
        scenario,
        isEnglish ? 'English' : 'Arabic',
      );
    } catch (e) {
      print('Error in getExplanation: $e');
      return isEnglish 
        ? 'Failed to get explanation. Please try again later.'
        : 'فشل في الحصول على الشرح. يرجى المحاولة مرة أخرى لاحقًا.';
    }
  }

  Future<Map<String, dynamic>> getFeedback(String standardId, String userSolution) async {
    try {
      return await _apiService.getFeedback(
        standardId,
        userSolution,
        isEnglish ? 'English' : 'Arabic',
      );
    } catch (e) {
      print('Error in getFeedback: $e');
      return {
        'feedback': isEnglish 
          ? 'Failed to get feedback. Please try again later.'
          : 'فشل في الحصول على التعليقات. يرجى المحاولة مرة أخرى لاحقًا.',
        'expert_solution': '',
      };
    }
  }

  Future<String> askCustomQuestion(String question) async {
    try {
      return await _apiService.askCustomQuestion(
        question,
        isEnglish ? 'English' : 'Arabic',
      );
    } catch (e) {
      print('Error in askCustomQuestion: $e');
      return isEnglish 
        ? 'Failed to get answer. Please try again later.'
        : 'فشل في الحصول على الإجابة. يرجى المحاولة مرة أخرى لاحقًا.';
    }
  }
}
