// lib/exercises/ex1_print_raw_json.dart
// Exercici 1 — Comprendre l'estructura del JSON anidat
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> ex1PrintRawJson() async {
  final uri = Uri.parse('https://restcountries.com/v2/name/peru');
  try {
    final res = await http.get(uri);
    print('Ex1 — HTTP ${res.statusCode}');
    final decoded = jsonDecode(res.body);
    final pretty = const JsonEncoder.withIndent('  ').convert(decoded);
    print(pretty);
    // Observacions manuals (visuals):
    // Country → name (String a v2; a v3.1 és Map {common,official,...})
    // Country → currencies (List<Map> a v2; Map<String,Map> a v3.1)
    // Country → languages (List<Map> a v2; Map<String,String> a v3.1)
    // Country → flags (Map amb png/svg)
  } catch (e) {
    print('Ex1 — Error: $e');
  }
}
