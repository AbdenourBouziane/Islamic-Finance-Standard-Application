import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../providers/app_state.dart'; // Changed from standard_provider.dart
import '../models/standard.dart';
import '../models/example.dart';
import '../widgets/loading_indicator.dart';

class StandardTutorialScreen extends StatefulWidget {
  const StandardTutorialScreen({super.key});

  @override
  State<StandardTutorialScreen> createState() => _StandardTutorialScreenState();
}

class _StandardTutorialScreenState extends State<StandardTutorialScreen> {
  final TextEditingController _solutionController = TextEditingController();
  String? _feedback;
  String? _expertSolution;
  bool _isLoadingFeedback = false;

  @override
  void initState() {
    super.initState();
    // Add listener to detect text changes
    _solutionController.addListener(() {
      setState(() {
        // This forces a rebuild when text changes
      });
    });
  }

  @override
  void dispose() {
    _solutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Changed from standardProvider
    
    if (appState.isLoading) {
      return const LoadingIndicator(
        message: 'Loading tutorial...',
      );
    }

    final selectedStandard = appState.standards.firstWhere(
      (std) => std.id == appState.selectedStandardId,
      orElse: () => appState.standards.first,
    );

    final selectedExample = appState.examples.firstWhere(
      (ex) => ex.standardId == selectedStandard.id,
      orElse: () => appState.examples.first,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, appState),
          const SizedBox(height: 16),
          _buildStandardSelector(context, appState),
          const SizedBox(height: 24),
          _buildExampleScenario(context, appState, selectedExample),
          const SizedBox(height: 24),
          _buildSolutionInput(context, appState),
          const SizedBox(height: 16),
          _buildSubmitButton(context, appState, selectedStandard),
          if (_isLoadingFeedback) ...[
            const SizedBox(height: 24),
            const Center(
              child: LoadingIndicator(
                message: 'Analyzing your solution...',
              ),
            ),
          ],
          if (_feedback != null && !_isLoadingFeedback) ...[
            const SizedBox(height: 24),
            _buildFeedback(context, appState),
          ],
          if (_expertSolution != null && _expertSolution!.isNotEmpty && !_isLoadingFeedback) ...[
            const SizedBox(height: 16),
            _buildExpertSolution(context, appState),
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
            Icons.school_rounded,
            color: const Color(0xFF1E8449),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              appState.isEnglish 
                ? 'Interactive Tutorial'
                : 'الدروس التفاعلية',
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E8449),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardSelector(BuildContext context, AppState appState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appState.isEnglish 
            ? 'Select a standard for tutorial:'
            : 'اختر معيارًا للدرس:',
          style: GoogleFonts.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                isExpanded: true,
                value: appState.selectedStandardId,
                onChanged: (value) {
                  if (value != null) {
                    appState.setSelectedStandard(value);
                    setState(() {
                      _feedback = null;
                      _expertSolution = null;
                      _solutionController.clear();
                    });
                  }
                },
                items: appState.standards.map((standard) {
                  return DropdownMenuItem<String>(
                    value: standard.id,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${standard.id} - ${appState.isEnglish ? standard.titleEn : standard.titleAr}',
                        style: GoogleFonts.tajawal(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1E8449)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExampleScenario(BuildContext context, AppState appState, Example example) {
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
                  Icons.assignment_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    appState.isEnglish ? 'Scenario:' : 'السيناريو:',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E8449),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              appState.isEnglish ? example.titleEn : example.titleAr,
              style: GoogleFonts.tajawal(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: MarkdownBody(
                data: appState.isEnglish ? example.scenarioEn : example.scenarioAr,
                styleSheet: MarkdownStyleSheet(
                  p: GoogleFonts.tajawal(
                    fontSize: 15,
                    height: 1.5,
                  ),
                  listBullet: GoogleFonts.tajawal(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolutionInput(BuildContext context, AppState appState) {
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
                  Icons.edit_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  appState.isEnglish ? 'Your Solution:' : 'الحل الخاص بك:',
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
              controller: _solutionController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: appState.isEnglish 
                  ? 'Enter your solution here...'
                  : 'أدخل الحل الخاص بك هنا...',
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

  Widget _buildSubmitButton(BuildContext context, AppState appState, Standard standard) {
    // Debug print to check button state
    print("StandardTutorial button state: isEmpty=${_solutionController.text.isEmpty}, isLoading=$_isLoadingFeedback");
    
    return Center(
      child: ElevatedButton.icon(
        onPressed: (_solutionController.text.trim().isEmpty || _isLoadingFeedback)
          ? null 
          : () async {
              print("Submit button pressed with solution: ${_solutionController.text}");
              setState(() {
                _isLoadingFeedback = true;
              });
              
              try {
                final result = await appState.getFeedback(
                  standard.id,
                  _solutionController.text,
                );
                
                if (mounted) {
                  setState(() {
                    _feedback = result['feedback'];
                    _expertSolution = result['expert_solution'];
                    _isLoadingFeedback = false;
                  });
                }
              } catch (e) {
                print("Error getting feedback: $e");
                if (mounted) {
                  setState(() {
                    _feedback = appState.isEnglish 
                      ? "Error: Failed to get feedback. Please try again."
                      : "خطأ: فشل في الحصول على التعليقات. يرجى المحاولة مرة أخرى.";
                    _isLoadingFeedback = false;
                  });
                }
              }
            },
        icon: _isLoadingFeedback 
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.check_circle_outline_rounded),
        label: Text(
          appState.isEnglish 
            ? (_isLoadingFeedback ? 'Checking...' : 'Check My Answer')
            : (_isLoadingFeedback ? 'جاري التحقق...' : 'تحقق من إجابتي')
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFeedback(BuildContext context, AppState appState) {
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
                  Icons.feedback_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  appState.isEnglish ? 'Feedback:' : 'التعليق:',
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
              data: _feedback ?? '',
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

  Widget _buildExpertSolution(BuildContext context, AppState appState) {
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
                  appState.isEnglish ? 'Expert Solution:' : 'حل الخبير:',
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
              data: _expertSolution ?? '',
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
