import 'package:flutter/material.dart';
import 'package:islamic_finance_education/providers/standards_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/loading_indicator.dart';

class GlossaryScreen extends StatelessWidget {
  const GlossaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final standardProvider = Provider.of<StandardProvider>(context);
    
    if (standardProvider.isLoading) {
      return const LoadingIndicator(
        message: 'Loading glossary...',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, standardProvider),
          const SizedBox(height: 16),
          ...standardProvider.glossaryTerms.map((term) => _buildGlossaryItem(
            context, 
            standardProvider,
            term.term, 
            standardProvider.isEnglish ? term.definitionEn : term.definitionAr,
          )).toList(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, StandardProvider standardProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E8449).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.book_rounded,
            color: const Color(0xFF1E8449),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  standardProvider.isEnglish 
                    ? 'Islamic Finance Glossary'
                    : 'مصطلحات التمويل الإسلامي',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E8449),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  standardProvider.isEnglish 
                    ? 'Key terms and concepts in Islamic finance'
                    : 'المصطلحات والمفاهيم الرئيسية في التمويل الإسلامي',
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlossaryItem(BuildContext context, StandardProvider standardProvider, String term, String definition) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E8449).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                term,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E8449),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              definition,
              style: GoogleFonts.tajawal(
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
