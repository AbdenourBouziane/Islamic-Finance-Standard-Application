import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/app_state.dart'; // Changed from standard_provider.dart
import 'standards_explorer_screen.dart';
import 'tutorial_screen.dart'; // Using tutorial_screen.dart instead of standard_tutorial_screen.dart
import 'glossary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Changed from standardProvider
    final size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, appState, size),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFeaturesList(context, appState),
                const SizedBox(height: 24),
                _buildGetStartedSection(context, appState),
                const SizedBox(height: 24),
                _buildAboutSection(context, appState),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppState appState, Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.25,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E8449), Color(0xFF2ECC71)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: appState.isEnglish ? -50 : null,
            left: appState.isEnglish ? null : -50,
            top: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.account_balance,
                size: 200,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appState.isEnglish 
                    ? 'Welcome to Islamic Finance Standards'
                    : 'مرحبًا بكم في معايير التمويل الإسلامي',
                  style: GoogleFonts.tajawal(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context, AppState appState) {
    final features = appState.isEnglish
      ? [
          'Explore the five key standards: FAS 4, FAS 7, FAS 10, FAS 28, and FAS 32',
          'Learn through real-world examples and cases',
          'Interactive tutorials to test your understanding',
          'Multilingual support (English and Arabic)',
          'Ask custom questions about Islamic finance standards',
        ]
      : [
          'استكشاف المعايير الخمسة الرئيسية: FAS 4، FAS 7، FAS 10، FAS 28، و FAS 32',
          'التعلم من خلال أمثلة وحالات من العالم الحقيقي',
          'دروس تفاعلية لاختبار فهمك',
          'دعم متعدد اللغات (الإنجليزية والعربية)',
          'اطرح أسئلة مخصصة حول معايير التمويل الإسلامي',
        ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  appState.isEnglish ? 'Features' : 'الميزات',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF1E8449),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedSection(BuildContext context, AppState appState) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_circle_filled_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  appState.isEnglish ? 'Get Started' : 'ابدأ الآن',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              appState.isEnglish
                ? 'Start by exploring the standards or try an interactive tutorial!'
                : 'ابدأ باستكشاف المعايير أو جرب درسًا تفاعليًا!',
              style: GoogleFonts.tajawal(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to Standards Explorer
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text(appState.isEnglish ? 'Standards Explorer' : 'مستكشف المعايير'),
                            ),
                            body: const StandardsExplorerScreen(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.explore_rounded, size: 18),
                    label: Text(appState.isEnglish ? 'Explore' : 'استكشف'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Navigate to Tutorial using a new route
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text(appState.isEnglish ? 'Tutorial' : 'الدرس'),
                            ),
                            body: const TutorialScreen(), // Changed to TutorialScreen
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.school_rounded, size: 18),
                    label: Text(appState.isEnglish ? 'Tutorial' : 'الدرس'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, AppState appState) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  appState.isEnglish ? 'About AAOIFI' : 'عن الهيئة',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              appState.isEnglish
                ? 'The Accounting and Auditing Organization for Islamic Financial Institutions (AAOIFI) is an Islamic international autonomous non-profit corporate body that prepares accounting, auditing, governance, ethics, and Shari\'a standards for Islamic financial institutions.'
                : 'هيئة المحاسبة والمراجعة للمؤسسات المالية الإسلامية هي هيئة إسلامية دولية مستقلة غير ربحية تعد معايير المحاسبة والمراجعة والحوكمة والأخلاق والشريعة للمؤسسات المالية الإسلامية.',
              style: GoogleFonts.tajawal(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Navigate to Glossary using a new route
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text(appState.isEnglish ? 'Glossary' : 'المصطلحات'),
                        ),
                        body: const GlossaryScreen(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.book_rounded, size: 18),
                label: Text(appState.isEnglish ? 'View Glossary' : 'عرض المصطلحات'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
