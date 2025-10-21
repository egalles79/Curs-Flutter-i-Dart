// ignore_for_file: avoid_print
import 'package:flutter_package_1/api_client.dart';
import 'package:flutter_package_1/reqres/reqres_api.dart';
import 'package:flutter_package_1/countries/countries_api.dart';

Future<void> demo() async {
  final client = ApiClient();

  // --- ReqRes ---
  final reqres = ReqResApi(client);
  // Llistar usuaris (pàgina 2)
  final users = await reqres.listUsers(page: 2);
  print('Hi ha ${users.data.length} usuaris a la pàgina ${users.page}');
  // Obtenir un usuari concret
  final u2 = await reqres.getUser(2);
  print('Usuari 2: ${u2?.firstName ?? '(desconegut)'} ${u2?.lastName ?? ''}'
      .trim());
  // Crear usuari
  final created = await reqres.createUser(name: 'Eloi', job: 'Professor');
  print('Creat id=${created.id} a ${created.updatedAtOrCreatedAt}');
  // Login (recorda que ReqRes té emails predefinits)
  // final auth = await reqres.login(email: 'eve.holt@reqres.in', password: 'cityslicka');
  // print('Token: ${auth.token}');

  // --- RestCountries ---
  final countries = CountriesApi(client);
  final spain = await countries.getSpain();
  print('Espanya: capital=${spain?.capital}, codi3=${spain?.alpha3Code}');

  client.close();
}
