import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:flutter_package_1/api_client.dart';
import 'package:flutter_package_1/countries/countries_api.dart';
import 'package:flutter_package_1/countries/country_models.dart';

void main() {
  group('CountriesApi', () {
    test('getSpain retorna la coincidència exacta amb fullText=true', () async {
      final mock = MockClient((request) async {
        expect(request.url.path, '/v2/name/spain');
        expect(request.url.queryParameters['fullText'], 'true');

        final payload = [
          {
            'name': 'Spain',
            'alpha2Code': 'ES',
            'alpha3Code': 'ESP',
            'capital': 'Madrid',
            'region': 'Europe',
            'subregion': 'Southern Europe',
            'population': 47000000,
            'timezones': ['UTC', 'UTC+01:00'],
            'languages': [
              {
                'iso639_1': 'es',
                'iso639_2': 'spa',
                'name': 'Spanish',
                'nativeName': 'Español'
              }
            ],
            'flag': 'https://flagcdn.com/es.svg'
          }
        ];
        return http.Response(jsonEncode(payload), 200,
            headers: {'content-type': 'application/json'});
      });

      final client = ApiClient(client: mock); // no cal apiKey per RestCountries
      final api = CountriesApi(client);

      final spain = await api.getSpain();
      expect(spain, isA<Country>());
      expect(spain!.alpha3Code, 'ESP');
      expect(spain.capital, 'Madrid');

      client.close();
    });
  });
}
