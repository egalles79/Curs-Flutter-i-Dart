// lib/exercises/ex2_country_name.dart
// Exercici 2 — Model anidat bàsic (Country + Name)
import '../models/country.dart';
import '../services/restcountries_api.dart';

Future<void> ex2CountryName() async {
  final api = RestCountriesApi();
  final country = await api.fetchCountryByName('peru');
  if (country == null) {
    print("Ex2 — No s'ha pogut obtenir el país");
    return;
  }
  print('Ex2 — País: ${country.name.common} | Capital: ${country.capital}');
}
