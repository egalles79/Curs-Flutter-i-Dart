// lib/exercises/ex3_models_with_lists.dart
// Exercici 3 — Models anidats i llistes (Country + Currency + Language)
import '../services/restcountries_api.dart';

Future<void> ex3ModelsWithLists() async {
  final api = RestCountriesApi();
  final country = await api.fetchCountryByName('peru');
  if (country == null) {
    print("Ex3 — No s'ha pogut obtenir el país");
    return;
  }
  final firstCurrencyName = country.currencies.values.isNotEmpty
      ? country.currencies.values.first.name
      : '(sense moneda)';
  final firstLanguage = country.languages.values.isNotEmpty
      ? country.languages.values.first
      : '(sense idioma)';
  print('Ex3 — País: ${country.name.common}');
  print('Ex3 — Capital: ${country.capital}');
  print('Ex3 — Moneda: $firstCurrencyName');
  print('Ex3 — Idioma principal: $firstLanguage');
}
