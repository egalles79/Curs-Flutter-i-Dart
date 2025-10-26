// lib/exercises/ex6_tojson.dart
// Exercici 6 — Conversió inversa (toJson) en models anidats
import 'dart:convert';
import '../services/restcountries_api.dart';

Future<void> ex6ToJson() async {
  final api = RestCountriesApi();
  final c = await api.fetchCountryByName('peru');
  if (c == null) {
    print("Ex6 — No s'ha pogut obtenir el país");
    return;
  }
  final jsonStr = const JsonEncoder.withIndent('  ').convert(c.toJson());
  print('Ex6 — Country.toJson() →');
  print(jsonStr);
}
