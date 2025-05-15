class Example {
  final String standardId;
  final String titleEn;
  final String titleAr;
  final String scenarioEn;
  final String scenarioAr;

  Example({
    required this.standardId,
    required this.titleEn,
    required this.titleAr,
    required this.scenarioEn,
    required this.scenarioAr,
  });

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      standardId: json['standard_id'] ?? json['standard_code'] ?? '', // Support both field names
      titleEn: json['title_en'] ?? '',
      titleAr: json['title_ar'] ?? '',
      scenarioEn: json['scenario_en'] ?? '',
      scenarioAr: json['scenario_ar'] ?? '',
    );
  }
}
