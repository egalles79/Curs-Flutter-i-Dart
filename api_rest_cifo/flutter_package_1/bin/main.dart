import 'package:flutter_package_1/api_client.dart';
import 'package:flutter_package_1/countries/countries_api.dart';
import 'package:flutter_package_1/reqres/reqres_api.dart';

void main() async {
  final client = ApiClient();

  final reqres = ReqResApi(client);
  final users = await reqres.listUsers(page: 2);
  print('P2 usuaris: ${users.data.length}');

  final countries = CountriesApi(client);
  final spain = await countries.getSpain();
  print('Capital d’Espanya: ${spain?.capital}');

  client.close();
}
