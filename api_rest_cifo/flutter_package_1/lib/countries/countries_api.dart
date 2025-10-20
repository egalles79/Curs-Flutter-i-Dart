import '../api_client.dart';
import 'country_models.dart';

/// Client per a RestCountries v2.
class CountriesApi {
  final ApiClient _client;
  final Uri _base;

  CountriesApi(ApiClient client, {String baseUrl = 'https://restcountries.com'})
      : _client = client,
        _base = Uri.parse(baseUrl);

  /// Cerca per nom. Exemple: 'spain' (pot retornar diverses entrades).
  /// [fullText] si és true, fa match exacte (?fullText=true).
  Future<List<Country>> searchByName(String name,
      {bool fullText = false}) async {
    final path = '/v2/name/$name';
    final params = <String, String>{if (fullText) 'fullText': 'true'};
    final uri = _base.replace(
        path: path, queryParameters: params.isEmpty ? null : params);

    final json = await _client.getJson(uri);
    if (json is List) {
      return json
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Helper específic: obtenir només Espanya (match exacte)
  Future<Country?> getSpain() async {
    final list = await searchByName('spain', fullText: true);
    return list.isEmpty ? null : list.first;
  }
}
