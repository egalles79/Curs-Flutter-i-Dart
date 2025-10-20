// Models per a RestCountries v2 (https://restcountries.com/)

class Language {
  final String? iso639_1;
  final String? iso639_2;
  final String name;
  final String? nativeName;

  Language({this.iso639_1, this.iso639_2, required this.name, this.nativeName});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        iso639_1: json['iso639_1'] as String?,
        iso639_2: json['iso639_2'] as String?,
        name: json['name'] as String,
        nativeName: json['nativeName'] as String?,
      );
}

class Country {
  final String name;
  final String alpha2Code;
  final String alpha3Code;
  final String? capital;
  final String region;
  final String? subregion;
  final int? population;
  final List<String> timezones;
  final List<Language> languages;
  final String flag; // URL a l'SVG

  Country({
    required this.name,
    required this.alpha2Code,
    required this.alpha3Code,
    this.capital,
    required this.region,
    this.subregion,
    this.population,
    required this.timezones,
    required this.languages,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name'] as String,
        alpha2Code: json['alpha2Code'] as String,
        alpha3Code: json['alpha3Code'] as String,
        capital: json['capital'] as String?,
        region: json['region'] as String? ?? '—',
        subregion: json['subregion'] as String?,
        population: (json['population'] as num?)?.toInt(),
        timezones: (json['timezones'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        languages: (json['languages'] as List<dynamic>? ?? [])
            .map((e) => Language.fromJson(e as Map<String, dynamic>))
            .toList(),
        flag: json['flag'] as String,
      );
}
