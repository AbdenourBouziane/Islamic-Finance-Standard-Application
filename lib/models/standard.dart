class Standard {
  final String id;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;

  Standard({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
  });

  factory Standard.fromJson(Map<String, dynamic> json) {
    return Standard(
      id: json['id'] ?? json['code'] ?? '', // Support both 'id' and 'code' for backward compatibility
      titleEn: json['title_en'] ?? '',
      titleAr: json['title_ar'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
    );
  }
}
