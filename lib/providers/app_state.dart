import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/standard.dart';
import '../models/example.dart';
import '../models/glossary_term.dart';
import '../data/mock_data.dart';

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

  String _apiBaseUrl = 'http://localhost:8000'; // For Android emulator
  // Use 'http://localhost:8000' for iOS simulator or web

  AppState() {
    _loadLanguagePreference();
    _initializeData();
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
    _saveLanguagePreference();
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
      print('Fetching standards from: $_apiBaseUrl/api/standards');
      final response = await http.get(Uri.parse('$_apiBaseUrl/api/standards'));
      
      if (response.statusCode == 200) {
        print('Standards response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        _standards = data.map((item) => Standard.fromJson(item)).toList();
      } else {
        print('Error fetching standards: ${response.statusCode}');
        // If server returns an error, use mock data
        _standards = MockData.standards.map((item) => Standard.fromJson(item)).toList();
      }
    } catch (e) {
      print('Exception fetching standards: $e');
      // If there's an error (like no connection), use mock data
      _standards = MockData.standards.map((item) => Standard.fromJson(item)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchExamples() async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Fetching examples from: $_apiBaseUrl/api/examples');
      final response = await http.get(Uri.parse('$_apiBaseUrl/api/examples'));
      
      if (response.statusCode == 200) {
        print('Examples response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        _examples = data.map((item) => Example.fromJson(item)).toList();
      } else {
        print('Error fetching examples: ${response.statusCode}');
        // If server returns an error, use mock data
        _examples = MockData.examples.map((item) => Example.fromJson(item)).toList();
      }
    } catch (e) {
      print('Exception fetching examples: $e');
      // If there's an error, use mock data
      _examples = MockData.examples.map((item) => Example.fromJson(item)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchGlossaryTerms() async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Fetching glossary from: $_apiBaseUrl/api/glossary');
      final response = await http.get(Uri.parse('$_apiBaseUrl/api/glossary'));
      
      if (response.statusCode == 200) {
        print('Glossary response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        _glossaryTerms = data.map((item) => GlossaryTerm.fromJson(item)).toList();
      } else {
        print('Error fetching glossary: ${response.statusCode}');
        // If server returns an error, use mock data
        _glossaryTerms = MockData.glossaryTerms.map((item) => GlossaryTerm.fromJson(item)).toList();
      }
    } catch (e) {
      print('Exception fetching glossary: $e');
      // If there's an error, use mock data
      _glossaryTerms = MockData.glossaryTerms.map((item) => GlossaryTerm.fromJson(item)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String> getExplanation(String standardId, String scenario) async {
    try {
      print('Sending explanation request to: $_apiBaseUrl/api/explanation');
      print('Request body: ${json.encode({
        'standard_id': standardId,
        'scenario': scenario,
        'language': isEnglish ? 'English' : 'Arabic',
      })}');
      
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/api/explanation'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'standard_id': standardId,
          'scenario': scenario,
          'language': isEnglish ? 'English' : 'Arabic',
        }),
      );
      
      print('Explanation response status: ${response.statusCode}');
      print('Explanation response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['explanation'];
      } else {
        print('Error getting explanation: ${response.statusCode}');
        // Return mock explanation as fallback
        return MockData.getExplanation(standardId, isEnglish ? 'English' : 'Arabic');
      }
    } catch (e) {
      print('Exception getting explanation: $e');
      // Return mock explanation as fallback
      return MockData.getExplanation(standardId, isEnglish ? 'English' : 'Arabic');
    }
  }

  Future<Map<String, dynamic>> getFeedback(String standardId, String userSolution) async {
    try {
      print('Sending feedback request to: $_apiBaseUrl/api/feedback');
      print('Request body: ${json.encode({
        'standard_id': standardId,
        'user_solution': userSolution,
        'language': isEnglish ? 'English' : 'Arabic',
      })}');
      
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/api/feedback'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'standard_id': standardId,
          'user_solution': userSolution,
          'language': isEnglish ? 'English' : 'Arabic',
        }),
      );
      
      print('Feedback response status: ${response.statusCode}');
      print('Feedback response body: ${response.body}');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error getting feedback: ${response.statusCode}');
        // Return mock feedback as fallback
        return {
          'feedback': MockData.getFeedback(isEnglish ? 'English' : 'Arabic'),
          'expert_solution': MockData.getExplanation(standardId, isEnglish ? 'English' : 'Arabic'),
        };
      }
    } catch (e) {
      print('Exception getting feedback: $e');
      // Return mock feedback as fallback
      return {
        'feedback': MockData.getFeedback(isEnglish ? 'English' : 'Arabic'),
        'expert_solution': MockData.getExplanation(standardId, isEnglish ? 'English' : 'Arabic'),
      };
    }
  }

  Future<String> askCustomQuestion(String question) async {
    try {
      print('Sending question to: $_apiBaseUrl/api/ask');
      print('Request body: ${json.encode({
        'question': question,
        'language': isEnglish ? 'English' : 'Arabic',
      })}');
      
      final response = await http.post(
        Uri.parse('$_apiBaseUrl/api/ask'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'question': question,
          'language': isEnglish ? 'English' : 'Arabic',
        }),
      );
      
      print('Question response status: ${response.statusCode}');
      print('Question response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['answer'];
      } else {
        print('Error asking question: ${response.statusCode}');
        // Return mock answer as fallback
        return MockData.getCustomAnswer(isEnglish ? 'English' : 'Arabic');
      }
    } catch (e) {
      print('Exception asking question: $e');
      // Return mock answer as fallback
      return MockData.getCustomAnswer(isEnglish ? 'English' : 'Arabic');
    }
  }
}
