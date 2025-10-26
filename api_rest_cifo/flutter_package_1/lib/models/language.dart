// lib/models/language.dart
// Model separat per als idiomes.

class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromMapEntry(MapEntry<String, dynamic> entry) {
    return Language(
      code: entry.key,
      name: entry.value?.toString() ?? '',
    );
  }

  factory Language.fromV2Map(Map<String, dynamic> json) {
    return Language(
      code: (json['iso639_1'] ?? '') as String,
      name: (json['name'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}
