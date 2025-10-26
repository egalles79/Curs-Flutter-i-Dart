// ignore_for_file: avoid_print

import 'package:flutter_package_1/api_client.dart';
import 'package:flutter_package_1/reqres/reqres_api.dart';
import 'package:flutter_package_1/reqres/reqres_models.dart';

import '../../flutter_package_1/lib/exercises/ex1_print_raw_json.dart';
import '../../flutter_package_1/lib/exercises/ex2_country_name.dart';
import '../../flutter_package_1/lib/exercises/ex3_models_with_lists.dart';
import '../../flutter_package_1/lib/exercises/ex4_fetch_with_errors.dart';
import '../../flutter_package_1/lib/exercises/ex5_deep_nested_names.dart';
import '../../flutter_package_1/lib/exercises/ex6_tojson.dart';
import '../../flutter_package_1/lib/exercises/ex7_multi_search.dart';

Future<void> main() async {
  final api = ReqResApi(ApiClient());

  // Exemple: obtenir recursos (colors)
  try {
    final resources = await api.listResources(page: 1);
    print('\nResources (colors):');
    for (final r in resources.data) {
      print('• ${r.name} (${r.year}) -> ${r.color}');
    }
  } on ApiException catch (e) {
    print('⚠️ listResources va fallar: ${e.statusCode} ${e.body}');
  }
  print('== Inici exercicis 23 octubre ==');
  await ex1PrintRawJson();
  await ex2CountryName();
  await ex3ModelsWithLists();
  await ex4FetchWithErrors();
  await ex5DeepNestedNames();
  await ex6ToJson();
  await ex7MultiSearch();
  print('== Fi exercicis ==');
  try {
    // Obtenim usuaris de la pàgina 2
    final users = await api.listUsers(page: 2);
    print('P${users.page} usuaris (${users.data.length} resultats):\n');

    // 🔹 Iterem i mostrem cada usuari amb camps reals
    for (final ReqResUser u in users.data) {
      print('ID: ${u.id}');
      print('Nom: ${u.firstName} ${u.lastName}');
      print('Email: ${u.email}');
      print('Avatar: ${u.avatar}');
      print('----------------------');
    }

    // Exemple: obtenir un usuari concret
    final single = await api.getUser(2);
    if (single != null) {
      print('\nUsuari concret: ${single.firstName} ${single.lastName}');
    }

    // Exemple: obtenir recursos (colors)
    final resources = await api.listResources(page: 1);
    print('\nResources (colors):');
    for (final r in resources.data) {
      print('• ${r.name} (${r.year}) -> ${r.color}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
