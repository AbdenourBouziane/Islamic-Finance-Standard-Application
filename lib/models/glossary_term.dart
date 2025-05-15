class GlossaryTerm {
  final String term;
  final String definitionEn;
  final String definitionAr;

  GlossaryTerm({
    required this.term,
    required this.definitionEn,
    required this.definitionAr,
  });

  factory GlossaryTerm.fromJson(Map<String, dynamic> json) {
    return GlossaryTerm(
      term: json['term'] ?? '',
      definitionEn: json['definition_en'] ?? '',
      definitionAr: json['definition_ar'] ?? '',
    );
  }
}
