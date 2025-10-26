// lib/exercises/ex7_multi_search.dart
// Exercici 7 — Cerca múltiple (List<Country>) amb continuació en errors
import '../services/restcountries_api.dart';

Future<void> ex7MultiSearch() async {
  final api = RestCountriesApi();
  final names = ['peru', 'spain', 'japan', 'xyz'];
  final found = <String>[];

  for (final n in names) {
    try {
      final c = await api.fetchCountryByNameStrict(n);
      found.add('${c.name.common} (${c.capital})');
    } catch (e) {
      // Continuem tot i l'error
      print('Ex7 — Avis: error amb "$n": $e');
    }
  }

  print('Ex7 — Resum:');
  for (final line in found) {
    print(' • $line');
  }
}
