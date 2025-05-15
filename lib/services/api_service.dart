import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/standard.dart';
import '../models/example.dart';
import '../models/glossary_term.dart';
import '../data/mock_data.dart';

class ApiService {
  // Update this URL with your Vercel deployment URL
  final String baseUrl = 'https://your-vercel-deployment-url.vercel.app/api'; 
  final bool useMockData = false; // We're now using the real API

  Future<List<Standard>> getStandards() async {
    if (useMockData) {
      // Return mock data
      return MockData.standards.map((json) => Standard.fromJson(json)).toList();
    }

    final response = await http.get(Uri.parse('$baseUrl/standards'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Standard.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load standards: ${response.statusCode}');
    }
  }

  Future<List<Example>> getExamples() async {
    if (useMockData) {
      // Return mock data
      return MockData.examples.map((json) => Example.fromJson(json)).toList();
    }

    final response = await http.get(Uri.parse('$baseUrl/examples'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Example.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load examples: ${response.statusCode}');
    }
  }

  Future<List<GlossaryTerm>> getGlossaryTerms() async {
    if (useMockData) {
      // Return mock data
      return MockData.glossaryTerms.map((json) => GlossaryTerm.fromJson(json)).toList();
    }

    final response = await http.get(Uri.parse('$baseUrl/glossary'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GlossaryTerm.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load glossary terms: ${response.statusCode}');
    }
  }

  Future<String> getExplanation(String standardCode, String scenario, String language) async {
    if (useMockData) {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      return MockData.getExplanation(standardCode, language);
    }

    final response = await http.post(
      Uri.parse('$baseUrl/explanation'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'standard_code': standardCode,
        'scenario': scenario,
        'language': language,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['explanation'];
    } else {
      throw Exception('Failed to get explanation: ${response.statusCode}');
    }
  }

  Future<String> getFeedback(String scenario, String userSolution, String expertSolution, String language) async {
    if (useMockData) {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      return MockData.getFeedback(language);
    }

    final response = await http.post(
      Uri.parse('$baseUrl/feedback'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'scenario': scenario,
        'user_solution': userSolution,
        'expert_solution': expertSolution,
        'language': language,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['feedback'];
    } else {
      throw Exception('Failed to get feedback: ${response.statusCode}');
    }
  }

  Future<String> getCustomAnswer(String question, String language) async {
    if (useMockData) {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      return MockData.getCustomAnswer(language);
    }

    final response = await http.post(
      Uri.parse('$baseUrl/custom-question'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'question': question,
        'language': language,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['answer'];
    } else {
      throw Exception('Failed to get answer: ${response.statusCode}');
    }
  }
}
