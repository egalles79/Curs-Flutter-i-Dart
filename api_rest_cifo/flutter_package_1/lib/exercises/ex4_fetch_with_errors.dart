// lib/exercises/ex4_fetch_with_errors.dart
// Exercici 4 — Petició dinàmica + maneig robust d'errors
import '../services/restcountries_api.dart';

Future<void> ex4FetchWithErrors() async {
  final api = RestCountriesApi();
  final queries = ['peru', 'chile', 'xyz'];
  for (final q in queries) {
    try {
      final c = await api.fetchCountryByNameStrict(q);
      print('Ex4 — OK: ${c.name.common} (${c.capital})');
    } on CountryNotFound {
      print('Ex4 — ❌ País no trobat: $q');
    } on HttpException catch (e) {
      print('Ex4 — Error servidor: ${e.status} (${e.apiVersion})');
    } on FormatException catch (e) {
      print('Ex4 — Error de format: ${e.message}');
    } catch (e) {
      print('Ex4 — Error desconegut: $e');
    }
  }
}
