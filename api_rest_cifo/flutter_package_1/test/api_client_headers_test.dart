import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:flutter_package_1/api_client.dart';

void main() {
  group('ApiClient', () {
    test('afegeix header x-api-key i retorna JSON', () async {
      final mock = MockClient((request) async {
        // Verifica el header injectat
        expect(request.headers['x-api-key'], equals('reqres-free-v1'));
        // Retorna JSON vàlid
        return http.Response(jsonEncode({'ok': true, 'n': 42}), 200,
            headers: {'content-type': 'application/json'});
      });

      final client = ApiClient(client: mock, apiKey: 'reqres-free-v1');
      final uri = Uri.parse('https://example.com/ping');

      final json = await client.getJson(uri) as Map<String, dynamic>;
      expect(json['ok'], isTrue);
      expect(json['n'], 42);
      client.close();
    });

    test('llança ApiException en codi no-2xx', () async {
      final mock = MockClient((request) async {
        return http.Response('Boom', 500);
      });

      final client = ApiClient(client: mock, apiKey: 'reqres-free-v1');
      final uri = Uri.parse('https://example.com/fail');

      expect(
        () => client.getJson(uri),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 'status', 500)),
      );
      client.close();
    });

    test('POST envia Content-Type i cos JSON', () async {
      final mock = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.headers['content-type'], contains('application/json'));
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['name'], 'Eloi');
        return http.Response(jsonEncode({'created': true}), 201);
      });

      final client = ApiClient(client: mock, apiKey: 'reqres-free-v1');
      final uri = Uri.parse('https://example.com/users');
      final res = await client.postJson(uri, body: {'name': 'Eloi'});
      expect((res as Map)['created'], true);
      client.close();
    });
  });
}
