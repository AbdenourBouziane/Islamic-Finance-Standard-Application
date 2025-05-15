import 'package:flutter/material.dart';
import 'package:islamic_finance_education/providers/standards_provider.dart';
import 'package:provider/provider.dart';
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
      return const LoadingIndicator();
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
          if (_feedback != null) ...[
            const SizedBox(height: 24),
            _buildFeedback(context, standardProvider),
          ],
          if (_expertSolution != null && _expertSolution!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildExpertSolution(context, standardProvider),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, StandardProvider standardProvider) {
    return Text(
      standardProvider.isEnglish 
        ? 'Interactive Tutorial'
        : 'الدروس التفاعلية',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E8449),
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
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
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
                  child: Text(
                    '${standard.id} - ${standardProvider.isEnglish ? standard.titleEn : standard.titleAr}',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExampleScenario(BuildContext context, StandardProvider standardProvider, Example example) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            standardProvider.isEnglish ? 'Scenario:' : 'السيناريو:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            standardProvider.isEnglish ? example.titleEn : example.titleAr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            standardProvider.isEnglish ? example.scenarioEn : example.scenarioAr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionInput(BuildContext context, StandardProvider standardProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          standardProvider.isEnglish ? 'Your Solution:' : 'الحل الخاص بك:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _solutionController,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: standardProvider.isEnglish 
              ? 'Enter your solution here...'
              : 'أدخل الحل الخاص بك هنا...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1E8449), width: 2),
            ),
          ),
        ),
      ],
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
        icon: _isLoadingFeedback 
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.check_circle_outline),
        label: Text(
          standardProvider.isEnglish 
            ? (_isLoadingFeedback ? 'Checking...' : 'Check My Answer')
            : (_isLoadingFeedback ? 'جاري التحقق...' : 'تحقق من إجابتي')
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFeedback(BuildContext context, StandardProvider standardProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E8449).withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1E8449).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            standardProvider.isEnglish ? 'Feedback:' : 'التعليق:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E8449),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _feedback ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildExpertSolution(BuildContext context, StandardProvider standardProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            standardProvider.isEnglish ? 'Expert Solution:' : 'حل الخبير:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _expertSolution ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
