import 'package:flutter/material.dart';
import 'package:islamic_finance_education/providers/standards_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../widgets/loading_indicator.dart';

class CustomQuestionScreen extends StatefulWidget {
  const CustomQuestionScreen({super.key});

  @override
  State<CustomQuestionScreen> createState() => _CustomQuestionScreenState();
}

class _CustomQuestionScreenState extends State<CustomQuestionScreen> {
  final TextEditingController _questionController = TextEditingController();
  String? _answer;
  bool _isLoadingAnswer = false;

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final standardProvider = Provider.of<StandardProvider>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, standardProvider),
          const SizedBox(height: 16),
          _buildQuestionInput(context, standardProvider),
          const SizedBox(height: 16),
          _buildAskButton(context, standardProvider),
          if (_isLoadingAnswer) ...[
            const SizedBox(height: 24),
            const Center(
              child: LoadingIndicator(
                message: 'Generating answer...',
              ),
            ),
          ],
          if (_answer != null && !_isLoadingAnswer) ...[
            const SizedBox(height: 24),
            _buildAnswer(context, standardProvider),
          ],
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
            Icons.question_answer_rounded,
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
                    ? 'Ask Your Own Question'
                    : 'اطرح سؤالك الخاص',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E8449),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  standardProvider.isEnglish 
                    ? 'Ask any question about Islamic finance standards'
                    : 'اطرح أي سؤال حول معايير التمويل الإسلامي',
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

  Widget _buildQuestionInput(BuildContext context, StandardProvider standardProvider) {
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
                  Icons.help_outline_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  standardProvider.isEnglish ? 'Your Question:' : 'سؤالك:',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E8449),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _questionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: standardProvider.isEnglish 
                  ? 'Type your question here...'
                  : 'اكتب سؤالك هنا...',
                hintStyle: GoogleFonts.tajawal(),
              ),
              style: GoogleFonts.tajawal(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAskButton(BuildContext context, StandardProvider standardProvider) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _isLoadingAnswer || _questionController.text.isEmpty
          ? null 
          : () async {
              setState(() {
                _isLoadingAnswer = true;
              });
              
              final answer = await standardProvider.askCustomQuestion(
                _questionController.text,
              );
              
              setState(() {
                _answer = answer;
                _isLoadingAnswer = false;
              });
            },
        icon: const Icon(Icons.send_rounded),
        label: Text(
          standardProvider.isEnglish 
            ? 'Ask Question'
            : 'اسأل السؤال'
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAnswer(BuildContext context, StandardProvider standardProvider) {
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
                  Icons.lightbulb_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  standardProvider.isEnglish ? 'Answer:' : 'الإجابة:',
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E8449),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            MarkdownBody(
              data: _answer ?? '',
              styleSheet: MarkdownStyleSheet(
                p: GoogleFonts.tajawal(
                  fontSize: 15,
                  height: 1.5,
                ),
                h1: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E8449),
                ),
                h2: GoogleFonts.tajawal(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                h3: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                listBullet: GoogleFonts.tajawal(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
