import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/standard.dart';
import '../models/example.dart';
import '../widgets/loading_indicator.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
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
    final appState = Provider.of<AppState>(context);
    
    if (appState.isLoading) {
      return const LoadingIndicator();
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
    return Text(
      appState.isEnglish 
        ? 'Interactive Tutorial'
        : 'الدروس التفاعلية',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E8449),
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
                  child: Text(
                    '${standard.id} - ${appState.isEnglish ? standard.titleEn : standard.titleAr}',
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

  Widget _buildExampleScenario(BuildContext context, AppState appState, Example example) {
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
            appState.isEnglish ? 'Scenario:' : 'السيناريو:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            appState.isEnglish ? example.titleEn : example.titleAr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            appState.isEnglish ? example.scenarioEn : example.scenarioAr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionInput(BuildContext context, AppState appState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appState.isEnglish ? 'Your Solution:' : 'الحل الخاص بك:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _solutionController,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: appState.isEnglish 
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
          onChanged: (text) {
            // Force rebuild when text changes
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, AppState appState, Standard standard) {
    // Debug print to check button state
    print("Tutorial button state: isEmpty=${_solutionController.text.isEmpty}, isLoading=$_isLoadingFeedback");
    
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
          : const Icon(Icons.check_circle_outline),
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
            appState.isEnglish ? 'Feedback:' : 'التعليق:',
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

  Widget _buildExpertSolution(BuildContext context, AppState appState) {
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
            appState.isEnglish ? 'Expert Solution:' : 'حل الخبير:',
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
