import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart'; // Changed from standard_provider.dart
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Use Future.microtask to avoid calling setState during build
    Future.microtask(() => _loadData());
  }

  Future<void> _loadData() async {
    final appState = Provider.of<AppState>(context, listen: false); // Changed from standardProvider
    
    // Initialize data
    await appState.fetchStandards();
    await appState.fetchExamples();
    await appState.fetchGlossaryTerms();
    
    // Navigate to main screen after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false); // Changed from standardProvider
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E8449), Color(0xFF2ECC71)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Text(
                appState.isEnglish 
                  ? 'Islamic Finance Standards'
                  : 'معايير التمويل الإسلامي',
                style: GoogleFonts.tajawal(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                appState.isEnglish 
                  ? 'Learn AAOIFI standards through simple examples'
                  : 'تعلم معايير هيئة المحاسبة والمراجعة للمؤسسات المالية الإسلامية من خلال أمثلة بسيطة',
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
