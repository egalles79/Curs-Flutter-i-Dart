// lib/models/country.dart
import 'name.dart';
import 'currency.dart';
import 'language.dart';

class Country {
  final Name name;
  final String region;
  final String capital;
  final Map<String, Currency> currencies; // v3.1
  final Map<String, String> languages; // v3.1

  Country({
    required this.name,
    required this.region,
    required this.capital,
    required this.currencies,
    required this.languages,
  });

  /// Accepta tant v3.1 com v2 (adaptant a l'estructura comuna del curs).
  factory Country.fromJson(Map<String, dynamic> json) {
    // name pot ser Map (v3.1) o String (v2)
    final nameField = json['name'];
    final Name nm =
        Name.fromDynamic(nameField ?? json['name'] ?? json['nativeName'] ?? '');

    // region: v2/v3.1 és String
    final region = (json['region'] ?? '') as String;

    // capital: v3.1 és List<String>, v2 és String
    String capital = '';
    final cap = json['capital'];
    if (cap is List && cap.isNotEmpty) {
      capital = cap.first.toString();
    } else if (cap is String) {
      capital = cap;
    }

    // currencies v3.1: Map<String, Map>; v2: List<Map>
    final Map<String, Currency> curr = {};
    final currRaw = json['currencies'];
    if (currRaw is Map<String, dynamic>) {
      currRaw.forEach((code, value) {
        if (value is Map<String, dynamic>) {
          curr[code] = Currency.fromJson(value);
        }
      });
    } else if (currRaw is List) {
      for (final e in currRaw) {
        if (e is Map<String, dynamic>) {
          final c = Currency.fromJson(e);
          final code = (e['code'] ?? 'und').toString();
          curr[code] = c;
        }
      }
    }

    // languages v3.1: Map<String,String>; v2: List<Map>
    final Map<String, String> langs = {};
    final langRaw = json['languages'];
    if (langRaw is Map<String, dynamic>) {
      langRaw.forEach((k, v) => langs[k] = v?.toString() ?? '');
    } else if (langRaw is List) {
      for (final e in langRaw) {
        if (e is Map<String, dynamic>) {
          final l = Language.fromV2Map(e);
          langs[l.code] = l.name;
        }
      }
    }

    return Country(
      name: nm,
      region: region,
      capital: capital,
      currencies: curr,
      languages: langs,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'region': region,
        'capital': capital,
        'currencies': currencies.map((k, v) => MapEntry(k, v.toJson())),
        'languages': languages,
      };
}
