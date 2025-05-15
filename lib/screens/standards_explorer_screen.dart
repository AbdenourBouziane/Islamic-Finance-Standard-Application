import 'package:flutter/material.dart';
import 'package:islamic_finance_education/providers/standards_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/standard.dart';
import '../models/example.dart';
import '../widgets/loading_indicator.dart';

class StandardsExplorerScreen extends StatefulWidget {
  const StandardsExplorerScreen({Key? key}) : super(key: key);

  @override
  State<StandardsExplorerScreen> createState() => _StandardsExplorerScreenState();
}

class _StandardsExplorerScreenState extends State<StandardsExplorerScreen> {
  String? _explanation;
  bool _isLoadingExplanation = false;

  @override
  Widget build(BuildContext context) {
    final standardProvider = Provider.of<StandardProvider>(context);
    
    if (standardProvider.isLoading) {
      return const LoadingIndicator(
        message: 'Loading standards...',
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
          _buildStandardDetails(context, standardProvider, selectedStandard),
          const SizedBox(height: 24),
          _buildExampleScenario(context, standardProvider, selectedExample),
          const SizedBox(height: 16),
          _buildExplanationButton(context, standardProvider, selectedStandard, selectedExample),
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
            _buildExplanation(context, standardProvider),
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
            Icons.explore_rounded,
            color: const Color(0xFF1E8449),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              standardProvider.isEnglish 
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

  Widget _buildStandardSelector(BuildContext context, StandardProvider standardProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          standardProvider.isEnglish ? 'Select a standard to learn more:' : 'حدد معيارًا لمعرفة المزيد:',
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
                      _explanation = null;
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

  Widget _buildStandardDetails(BuildContext context, StandardProvider standardProvider, Standard standard) {
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
                    standardProvider.isEnglish ? standard.titleEn : standard.titleAr,
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
              standardProvider.isEnglish ? standard.descriptionEn : standard.descriptionAr,
              style: GoogleFonts.tajawal(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
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
                  Icons.lightbulb_rounded,
                  color: const Color(0xFF1E8449),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    standardProvider.isEnglish ? 'Example Scenario:' : 'سيناريو مثال:',
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

  Widget _buildExplanationButton(BuildContext context, StandardProvider standardProvider, Standard standard, Example example) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _isLoadingExplanation 
          ? null 
          : () async {
              setState(() {
                _isLoadingExplanation = true;
              });
              
              final explanation = await standardProvider.getExplanation(
                standard.id,
                standardProvider.isEnglish ? example.scenarioEn : example.scenarioAr,
              );
              
              setState(() {
                _explanation = explanation;
                _isLoadingExplanation = false;
              });
            },
        icon: const Icon(Icons.lightbulb_outline_rounded),
        label: Text(
          standardProvider.isEnglish 
            ? 'Get Explanation'
            : 'الحصول على شرح'
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildExplanation(BuildContext context, StandardProvider standardProvider) {
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
                  standardProvider.isEnglish ? 'Explanation:' : 'الشرح:',
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
