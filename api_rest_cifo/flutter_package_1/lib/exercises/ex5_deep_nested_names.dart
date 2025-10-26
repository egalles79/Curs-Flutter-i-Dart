// lib/exercises/ex5_deep_nested_names.dart
// Exercici 5 — Model amb model dins de model (Country → Name → NativeName)
import '../services/restcountries_api.dart';

Future<void> ex5DeepNestedNames() async {
  final api = RestCountriesApi();
  final country = await api.fetchCountryByName('peru');
  if (country == null) {
    print("Ex5 — No s'ha pogut obtenir el país");
    return;
  }
  print('Ex5 — Nom comú: ${country.name.common}');
  print('Ex5 — Nom oficial: ${country.name.official}');
  final spa = country.name.nativeName['spa'];
  print('Ex5 — Nom natiu espanyol: ${spa?.common ?? '(no disponible)'}');
}
