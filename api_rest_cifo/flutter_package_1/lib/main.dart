// ignore_for_file: avoid_print
import 'package:flutter_package_1/api_client.dart';
import 'package:flutter_package_1/reqres/reqres_api.dart';
import 'package:flutter_package_1/reqres/reqres_models.dart';

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
