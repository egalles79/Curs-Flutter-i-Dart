import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:flutter_package_1/api_client.dart';
import 'package:flutter_package_1/reqres/reqres_api.dart';
import 'package:flutter_package_1/reqres/reqres_models.dart';

void main() {
  group('ReqResApi', () {
    test('listUsers(page) fa GET correcte i parseja', () async {
      final mock = MockClient((request) async {
        expect(request.url.path, contains('/api/users'));
        expect(request.url.queryParameters['page'], '2');
        // mostra un llistat mínim vàlid de ReqRes
        final payload = {
          'page': 2,
          'per_page': 6,
          'total': 12,
          'total_pages': 2,
          'data': [
            {
              'id': 1,
              'email': 'george.bluth@reqres.in',
              'first_name': 'George',
              'last_name': 'Bluth',
              'avatar': 'https://reqres.in/img/faces/1-image.jpg'
            }
          ],
          'support': {
            'url': 'https://reqres.in/#support-heading',
            'text': 'Thanks!'
          }
        };
        return http.Response(jsonEncode(payload), 200,
            headers: {'content-type': 'application/json'});
      });

      final client = ApiClient(client: mock, apiKey: 'reqres-free-v1');
      final api = ReqResApi(client);

      final list = await api.listUsers(page: 2);
      expect(list, isA<ReqResUserList>());
      expect(list.page, 2);
      expect(list.data.first.firstName, 'George');

      client.close();
    });

    test('createUser envia PATCH/POST JSON i rep eco', () async {
      final mock = MockClient((request) async {
        expect(request.url.path, contains('/api/users'));
        expect(request.method, anyOf(equals('POST'), equals('PATCH')));

        final body = jsonDecode(request.body);
        expect(body['name'], 'Eloi');
        expect(body['job'], 'Professor');

        final response = {
          'name': 'Eloi',
          'job': 'Professor',
          'id': '999',
          'createdAt': '2025-10-17T10:00:00.000Z'
        };
        return http.Response(jsonEncode(response), 201);
      });

      final client = ApiClient(client: mock, apiKey: 'reqres-free-v1');
      final api = ReqResApi(client);

      final created = await api.createUser(name: 'Eloi', job: 'Professor');
      expect(created.id, '999');
      expect(created.updatedAtOrCreatedAt.year, 2025);

      client.close();
    });
  });
}
