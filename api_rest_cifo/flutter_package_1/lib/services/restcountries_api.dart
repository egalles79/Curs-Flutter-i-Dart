// lib/services/restcountries_api.dart
// Servei d'accés a l'API amb maneig d'errors i compatibilitat v2/v3.1
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class RestCountriesApi {
  final http.Client _client;
  RestCountriesApi({http.Client? client}) : _client = client ?? http.Client();

  /// Intenta v3.1 i si falla, prova v2. Retorna la primera coincidència.
  Future<Country?> fetchCountryByName(String name) async {
    try {
      // Primer intent: v3.1
      final v31 = Uri.parse('https://restcountries.com/v3.1/name/$name');
      final r1 = await _client.get(v31);
      if (r1.statusCode == 200) {
        final data = jsonDecode(r1.body);
        if (data is List && data.isNotEmpty && data.first is Map<String, dynamic>) {
          return Country.fromJson(data.first as Map<String, dynamic>);
        }
      } else if (r1.statusCode == 404) {
        // si 404 a v3.1, intentem v2
      } else {
        // errors 5xx o altres
        // provem v2 igualment per robustesa
      }

      // Segon intent: v2
      final v2 = Uri.parse('https://restcountries.com/v2/name/$name');
      final r2 = await _client.get(v2);
      if (r2.statusCode == 200) {
        final data = jsonDecode(r2.body);
        if (data is List && data.isNotEmpty && data.first is Map<String, dynamic>) {
          return Country.fromJson(data.first as Map<String, dynamic>);
        }
      } else if (r2.statusCode == 404) {
        print('❌ País no trobat: $name');
        return null;
      } else {
        throw Exception('Error del servidor: ${r2.statusCode}');
      }
    } catch (e) {
      print('⚠️ Error de xarxa o parseig: $e');
      return null;
    }
    return null;
  }

  /// Versió que llença excepcions específiques per a l'Ex4.
  Future<Country> fetchCountryByNameStrict(String name) async {
    final v31 = Uri.parse('https://restcountries.com/v3.1/name/$name');
    final r1 = await _client.get(v31);
    if (r1.statusCode == 200) {
      final data = jsonDecode(r1.body);
      if (data is List && data.isNotEmpty && data.first is Map<String, dynamic>) {
        return Country.fromJson(data.first as Map<String, dynamic>);
      }
      throw const FormatException('Estructura inesperada a v3.1');
    } else if (r1.statusCode == 404) {
      // provem v2
    } else {
      throw HttpException(r1.statusCode, 'v3.1');
    }

    final v2 = Uri.parse('https://restcountries.com/v2/name/$name');
    final r2 = await _client.get(v2);
    if (r2.statusCode == 200) {
      final data = jsonDecode(r2.body);
      if (data is List && data.isNotEmpty && data.first is Map<String, dynamic>) {
        return Country.fromJson(data.first as Map<String, dynamic>);
      }
      throw const FormatException('Estructura inesperada a v2');
    } else if (r2.statusCode == 404) {
      throw CountryNotFound(name);
    } else {
      throw HttpException(r2.statusCode, 'v2');
    }
  }
}

class CountryNotFound implements Exception {
  final String query;
  const CountryNotFound(this.query);
  @override
  String toString() => 'CountryNotFound: $query';
}

class HttpException implements Exception {
  final int status;
  final String apiVersion;
  const HttpException(this.status, this.apiVersion);
  @override
  String toString() => 'HttpException($status) on $apiVersion';
}
