import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/app_state.dart'; 
import 'home_screen.dart';
import 'standards_explorer_screen.dart';
import 'tutorial_screen.dart';
import 'glossary_screen.dart';
import 'custom_question_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const StandardsExplorerScreen(),
    const TutorialScreen(), 
    const GlossaryScreen(),
    const CustomQuestionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Changed to AppState
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appState.isEnglish ? 'Islamic Finance Standards' : 'معايير التمويل الإسلامي',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              appState.toggleLanguage();
            },
            tooltip: appState.isEnglish ? 'Switch to Arabic' : 'التبديل إلى الإنجليزية',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF1E8449),
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: GoogleFonts.tajawal(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.tajawal(),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: appState.isEnglish ? 'Home' : 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore_rounded),
              label: appState.isEnglish ? 'Standards' : 'المعايير',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school_rounded),
              label: appState.isEnglish ? 'Tutorial' : 'الدروس',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.book_rounded),
              label: appState.isEnglish ? 'Glossary' : 'المصطلحات',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.question_answer_rounded),
              label: appState.isEnglish ? 'Ask' : 'اسأل',
            ),
          ],
        ),
      ),
    );
  }
}
