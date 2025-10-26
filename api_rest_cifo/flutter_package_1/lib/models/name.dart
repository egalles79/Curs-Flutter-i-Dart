// lib/models/name.dart
// Comentaris en català: model Name compatible amb v2 i v3.1 de RestCountries.
class NativeName {
  final String official;
  final String common;

  NativeName({required this.official, required this.common});

  factory NativeName.fromJson(Map<String, dynamic> json) {
    return NativeName(
      official: (json['official'] ?? '') as String,
      common: (json['common'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'official': official,
        'common': common,
      };
}

class Name {
  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  Name({required this.common, required this.official, required this.nativeName});

  /// Accepta:
  /// v3.1: {"common":"Peru","official":"Republic of Peru","nativeName":{"spa":{"official":"República del Perú","common":"Perú"}}}
  /// v2:   {"name":"Peru","nativeName":"Perú"} → ho adaptem a Name (common=name, official=name)
  factory Name.fromDynamic(dynamic data) {
    if (data is Map<String, dynamic>) {
      // v3.1
      final common = (data['common'] ?? data['name'] ?? '') as String;
      final official = (data['official'] ?? data['name'] ?? common) as String;
      final nativeRaw = data['nativeName'];
      final nativeMap = <String, NativeName>{};
      if (nativeRaw is Map<String, dynamic>) {
        nativeRaw.forEach((k, v) {
          if (v is Map<String, dynamic>) {
            nativeMap[k] = NativeName.fromJson(v);
          }
        });
      } else if (data['nativeName'] is String) {
        // v2-like single nativeName string
        final s = data['nativeName'] as String;
        nativeMap['und'] = NativeName(official: s, common: s);
      }
      return Name(common: common, official: official, nativeName: nativeMap);
    } else if (data is String) {
      // v2 simple: name as string
      return Name(common: data, official: data, nativeName: {});
    }
    return Name(common: '', official: '', nativeName: {});
  }

  Map<String, dynamic> toJson() => {
        'common': common,
        'official': official,
        'nativeName':
            nativeName.map((k, v) => MapEntry(k, v.toJson())),
      };
}
