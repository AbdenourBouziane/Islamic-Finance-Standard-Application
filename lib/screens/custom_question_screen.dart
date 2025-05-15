import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../providers/app_state.dart';
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
  void initState() {
    super.initState();
    // Add listener to detect text changes
    _questionController.addListener(() {
      setState(() {
        // This forces a rebuild when text changes
      });
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, appState),
          const SizedBox(height: 16),
          _buildQuestionInput(context, appState),
          const SizedBox(height: 16),
          _buildAskButton(context, appState),
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
            _buildAnswer(context, appState),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppState appState) {
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
                  appState.isEnglish 
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
                  appState.isEnglish 
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

  Widget _buildQuestionInput(BuildContext context, AppState appState) {
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
                  appState.isEnglish ? 'Your Question:' : 'سؤالك:',
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
                hintText: appState.isEnglish 
                  ? 'Type your question here...'
                  : 'اكتب سؤالك هنا...',
                hintStyle: GoogleFonts.tajawal(),
              ),
              style: GoogleFonts.tajawal(
                fontSize: 15,
              ),
              onChanged: (text) {
                // Force rebuild when text changes
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAskButton(BuildContext context, AppState appState) {
    // Debug print to check button state
    print("Button state: isEmpty=${_questionController.text.isEmpty}, isLoading=$_isLoadingAnswer");
    
    return Center(
      child: ElevatedButton.icon(
        onPressed: (_questionController.text.trim().isEmpty || _isLoadingAnswer)
          ? null 
          : () async {
              print("Ask button pressed with question: ${_questionController.text}");
              setState(() {
                _isLoadingAnswer = true;
              });
              
              try {
                final answer = await appState.askCustomQuestion(
                  _questionController.text,
                );
                
                if (mounted) {
                  setState(() {
                    _answer = answer;
                    _isLoadingAnswer = false;
                  });
                }
              } catch (e) {
                print("Error asking question: $e");
                if (mounted) {
                  setState(() {
                    _answer = appState.isEnglish 
                      ? "Error: Failed to get an answer. Please try again."
                      : "خطأ: فشل في الحصول على إجابة. يرجى المحاولة مرة أخرى.";
                    _isLoadingAnswer = false;
                  });
                }
              }
            },
        icon: _isLoadingAnswer 
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.send_rounded),
        label: Text(
          appState.isEnglish 
            ? (_isLoadingAnswer ? 'Processing...' : 'Ask Question')
            : (_isLoadingAnswer ? 'جاري المعالجة...' : 'اسأل السؤال')
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAnswer(BuildContext context, AppState appState) {
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
                  appState.isEnglish ? 'Answer:' : 'الإجابة:',
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
