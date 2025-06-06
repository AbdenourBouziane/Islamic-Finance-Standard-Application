import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../providers/app_state.dart'; // Changed from standard_provider.dart
import '../models/standard.dart';
import '../models/example.dart';
import '../widgets/loading_indicator.dart';

class StandardsExplorerScreen extends StatefulWidget {
  const StandardsExplorerScreen({super.key});

  @override
  State<StandardsExplorerScreen> createState() => _StandardsExplorerScreenState();
}

class _StandardsExplorerScreenState extends State<StandardsExplorerScreen> {
  String? _explanation;
  bool _isLoadingExplanation = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Changed from standardProvider
    
    if (appState.isLoading) {
      return const LoadingIndicator(
        message: 'Loading standards...',
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
          _buildStandardDetails(context, appState, selectedStandard),
          const SizedBox(height: 24),
          _buildExampleScenario(context, appState, selectedExample),
          const SizedBox(height: 16),
          _buildExplanationButton(context, appState, selectedStandard, selectedExample),
          if (_isLoadingExplanation) ...[
            const SizedBox(height: 24),
            const Center(
              child: LoadingIndicator(
                message: 'Generating explanation...',
              ),
            ),
          ],
          if (_explanation != null && !_isLoadingExplanation) ...[
            const SizedBox(height: 24),
            _buildExplanation(context, appState),
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
            Icons.explore_rounded,
            color: const Color(0xFF1E8449),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              appState.isEnglish 
                ? 'AAOIFI Standards Explorer'
                : 'مستكشف معايير هيئة المحاسبة والمراجعة للمؤسسات المالية الإسلامية',
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
          appState.isEnglish ? 'Select a standard to learn more:' : 'حدد معيارًا لمعرفة المزيد:',
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
                      _explanation = null;
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

  Widget _buildStandardDetails(BuildContext context, AppState appState, Standard standard) {
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
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E8449).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    standard.id,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E8449),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    appState.isEnglish ? standard.titleEn : standard.titleAr,
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              appState.isEnglish ? standard.descriptionEn : standard.descriptionAr,
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
                  Icons.lightbulb_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    appState.isEnglish ? 'Example Scenario:' : 'سيناريو مثال:',
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

  Widget _buildExplanationButton(BuildContext context, AppState appState, Standard standard, Example example) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _isLoadingExplanation 
          ? null 
          : () async {
              setState(() {
                _isLoadingExplanation = true;
              });
              
              final explanation = await appState.getExplanation(
                standard.id,
                appState.isEnglish ? example.scenarioEn : example.scenarioAr,
              );
              
              setState(() {
                _explanation = explanation;
                _isLoadingExplanation = false;
              });
            },
        icon: const Icon(Icons.lightbulb_outline_rounded),
        label: Text(
          appState.isEnglish 
            ? 'Get Explanation'
            : 'الحصول على شرح'
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildExplanation(BuildContext context, AppState appState) {
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
                  Icons.school_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  appState.isEnglish ? 'Explanation:' : 'الشرح:',
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
              data: _explanation ?? '',
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
