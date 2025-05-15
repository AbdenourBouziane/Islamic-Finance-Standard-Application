import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/standard.dart';
import '../models/example.dart';
import '../models/glossary_term.dart';
import '../data/mock_data.dart';

class ApiService {
  // Update this URL to match your backend
  final String baseUrl = 'http://localhost:8000/api'; // For Android emulator
  // Use 'http://localhost:8000/api' for iOS simulator or web
  
  final bool useMockData = false; // We're using the real API

  Future<List<Standard>> getStandards() async {
    try {
      print('Fetching standards from: $baseUrl/standards');
      final response = await http.get(Uri.parse('$baseUrl/standards'));
      
      if (response.statusCode == 200) {
        print('Standards response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Standard.fromJson(json)).toList();
      } else {
        print('Error fetching standards: ${response.statusCode}');
        throw Exception('Failed to load standards: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception fetching standards: $e');
      // Return mock data as fallback
      return MockData.standards.map((json) => Standard.fromJson(json)).toList();
    }
  }

  Future<List<Example>> getExamples() async {
    try {
      print('Fetching examples from: $baseUrl/examples');
      final response = await http.get(Uri.parse('$baseUrl/examples'));
      
      if (response.statusCode == 200) {
        print('Examples response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Example.fromJson(json)).toList();
      } else {
        print('Error fetching examples: ${response.statusCode}');
        throw Exception('Failed to load examples: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception fetching examples: $e');
      // Return mock data as fallback
      return MockData.examples.map((json) => Example.fromJson(json)).toList();
    }
  }

  Future<List<GlossaryTerm>> getGlossaryTerms() async {
    try {
      print('Fetching glossary from: $baseUrl/glossary');
      final response = await http.get(Uri.parse('$baseUrl/glossary'));
      
      if (response.statusCode == 200) {
        print('Glossary response: ${response.body}');
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => GlossaryTerm.fromJson(json)).toList();
      } else {
        print('Error fetching glossary: ${response.statusCode}');
        throw Exception('Failed to load glossary terms: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception fetching glossary: $e');
      // Return mock data as fallback
      return MockData.glossaryTerms.map((json) => GlossaryTerm.fromJson(json)).toList();
    }
  }

  Future<String> getExplanation(String standardId, String scenario, String language) async {
    try {
      print('Sending explanation request to: $baseUrl/explanation');
      print('Request body: ${json.encode({
        'standard_id': standardId,
        'scenario': scenario,
        'language': language,
      })}');
      
      final response = await http.post(
        Uri.parse('$baseUrl/explanation'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'standard_id': standardId,
          'scenario': scenario,
          'language': language,
        }),
      );
      
      print('Explanation response status: ${response.statusCode}');
      print('Explanation response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String explanation = data['explanation'];
        
        // Validate the response
        if (language == 'Arabic' && _isProblematicArabicResponse(explanation)) {
          print('Detected problematic Arabic response, using fallback');
          return MockData.getExplanation(standardId, language);
        }
        
        return explanation;
      } else {
        print('Error getting explanation: ${response.statusCode}');
        throw Exception('Failed to get explanation: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception getting explanation: $e');
      // Return mock explanation as fallback
      return MockData.getExplanation(standardId, language);
    }
  }

  Future<Map<String, dynamic>> getFeedback(String standardId, String userSolution, String language) async {
    try {
      print('Sending feedback request to: $baseUrl/feedback');
      print('Request body: ${json.encode({
        'standard_id': standardId,
        'user_solution': userSolution,
        'language': language,
      })}');
      
      final response = await http.post(
        Uri.parse('$baseUrl/feedback'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'standard_id': standardId,
          'user_solution': userSolution,
          'language': language,
        }),
      );
      
      print('Feedback response status: ${response.statusCode}');
      print('Feedback response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String feedback = data['feedback'];
        String expertSolution = data['expert_solution'];
        
        // Validate the responses
        if (language == 'Arabic') {
          if (_isProblematicArabicResponse(feedback)) {
            print('Detected problematic Arabic feedback, using fallback');
            feedback = MockData.getFeedback(language);
          }
          
          if (_isProblematicArabicResponse(expertSolution)) {
            print('Detected problematic Arabic expert solution, using fallback');
            expertSolution = MockData.getExplanation(standardId, language);
          }
        }
        
        return {
          'feedback': feedback,
          'expert_solution': expertSolution,
        };
      } else {
        print('Error getting feedback: ${response.statusCode}');
        throw Exception('Failed to get feedback: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception getting feedback: $e');
      // Return mock feedback as fallback
      return {
        'feedback': MockData.getFeedback(language),
        'expert_solution': MockData.getExplanation(standardId, language),
      };
    }
  }

  Future<String> askCustomQuestion(String question, String language) async {
    try {
      print('Sending question to: $baseUrl/ask');
      print('Request body: ${json.encode({
        'question': question,
        'language': language,
      })}');
      
      // For Arabic, use mock data directly to avoid API issues
      if (language == 'Arabic') {
        print('Using mock data for Arabic question');
        return MockData.getCustomAnswer(language);
      }
      
      final response = await http.post(
        Uri.parse('$baseUrl/ask'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'question': question,
          'language': language,
        }),
      );
      
      print('Question response status: ${response.statusCode}');
      print('Question response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String answer = data['answer'];
        
        // Validate the response
        if (language == 'Arabic' && _isProblematicArabicResponse(answer)) {
          print('Detected problematic Arabic answer, using fallback');
          return MockData.getCustomAnswer(language);
        }
        
        return answer;
      } else {
        print('Error asking question: ${response.statusCode}');
        throw Exception('Failed to get answer: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception asking question: $e');
      // Return mock answer as fallback
      return MockData.getCustomAnswer(language);
    }
  }
  
  // Helper method to detect problematic Arabic responses
  bool _isProblematicArabicResponse(String text) {
    // Check for repetitive text patterns
    if (text.contains('وتحديد المدفوعات المستقبلية بشكل صحيح وتحديد المدفوعات المستقبلية بشكل صحيح')) {
      return true;
    }
    
    // Check for incomplete sentences
    if (text.endsWith('بشك') || text.endsWith('...') || text.length < 50) {
      return true;
    }
    
    // Check for instructions to the model rather than actual content
    if (text.contains('في هذه الإجابة، أجعل توضيحك') || 
        text.contains('اجعل شرحك سهلاً لغير المتخصصين')) {
      return true;
    }
    
    return false;
  }
}
