import 'package:flutter/material.dart';
import 'package:islamic_finance_education/providers/standards_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
  void dispose() {
    _solutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final standardProvider = Provider.of<StandardProvider>(context);
    
    if (standardProvider.isLoading) {
      return const LoadingIndicator(
        message: 'Loading tutorial...',
      );
    }

    final selectedStandard = standardProvider.standards.firstWhere(
      (std) => std.id == standardProvider.selectedStandardId,
      orElse: () => standardProvider.standards.first,
    );

    final selectedExample = standardProvider.examples.firstWhere(
      (ex) => ex.standardId == selectedStandard.id,
      orElse: () => standardProvider.examples.first,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, standardProvider),
          const SizedBox(height: 16),
          _buildStandardSelector(context, standardProvider),
          const SizedBox(height: 24),
          _buildExampleScenario(context, standardProvider, selectedExample),
          const SizedBox(height: 24),
          _buildSolutionInput(context, standardProvider),
          const SizedBox(height: 16),
          _buildSubmitButton(context, standardProvider, selectedStandard),
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
            _buildFeedback(context, standardProvider),
          ],
          if (_expertSolution != null && _expertSolution!.isNotEmpty && !_isLoadingFeedback) ...[
            const SizedBox(height: 16),
            _buildExpertSolution(context, standardProvider),
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
            Icons.school_rounded,
            color: const Color(0xFF1E8449),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              standardProvider.isEnglish 
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

  Widget _buildStandardSelector(BuildContext context, StandardProvider standardProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          standardProvider.isEnglish 
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
                value: standardProvider.selectedStandardId,
                onChanged: (value) {
                  if (value != null) {
                    standardProvider.setSelectedStandard(value);
                    setState(() {
                      _feedback = null;
                      _expertSolution = null;
                      _solutionController.clear();
                    });
                  }
                },
                items: standardProvider.standards.map((standard) {
                  return DropdownMenuItem<String>(
                    value: standard.id,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${standard.id} - ${standardProvider.isEnglish ? standard.titleEn : standard.titleAr}',
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

  Widget _buildExampleScenario(BuildContext context, StandardProvider standardProvider, Example example) {
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
                    standardProvider.isEnglish ? 'Scenario:' : 'السيناريو:',
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
              standardProvider.isEnglish ? example.titleEn : example.titleAr,
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
              child: Text(
                standardProvider.isEnglish ? example.scenarioEn : example.scenarioAr,
                style: GoogleFonts.tajawal(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolutionInput(BuildContext context, StandardProvider standardProvider) {
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
                  standardProvider.isEnglish ? 'Your Solution:' : 'الحل الخاص بك:',
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
                hintText: standardProvider.isEnglish 
                  ? 'Enter your solution here...'
                  : 'أدخل الحل الخاص بك هنا...',
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

  Widget _buildSubmitButton(BuildContext context, StandardProvider standardProvider, Standard standard) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _isLoadingFeedback || _solutionController.text.isEmpty
          ? null 
          : () async {
              setState(() {
                _isLoadingFeedback = true;
              });
              
              final result = await standardProvider.getFeedback(
                standard.id,
                _solutionController.text,
              );
              
              setState(() {
                _feedback = result['feedback'];
                _expertSolution = result['expert_solution'];
                _isLoadingFeedback = false;
              });
            },
        icon: const Icon(Icons.check_circle_outline_rounded),
        label: Text(
          standardProvider.isEnglish 
            ? 'Check My Answer'
            : 'تحقق من إجابتي'
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFeedback(BuildContext context, StandardProvider standardProvider) {
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
                  standardProvider.isEnglish ? 'Feedback:' : 'التعليق:',
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

  Widget _buildExpertSolution(BuildContext context, StandardProvider standardProvider) {
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
                  standardProvider.isEnglish ? 'Expert Solution:' : 'حل الخبير:',
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
