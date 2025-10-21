// ignore_for_file: public_member_api_docs
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Excepció genèrica per a errors d'API.
/// Conté el codi HTTP, un missatge descriptiu i, opcionalment, el cos de la resposta.
class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final String? body;

  ApiException(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'ApiException($statusCode): $message\n$body';
}

/// Client HTTP genèric amb suport per JSON, timeouts i capçaleres globals.
/// Es pot reutilitzar per a qualsevol servei REST (ReqRes, RestCountries, etc.)
class ApiClient {
  final http.Client _client;
  final Duration timeout;
  final String? apiKey; // Clau opcional per a serveis que ho requereixen

  /// Constructor principal.
  /// Pots passar-hi una [apiKey] si el servei la requereix (p.ex. ReqRes).
  ApiClient({
    http.Client? client,
    this.timeout = const Duration(seconds: 12),
    this.apiKey,
  }) : _client = client ?? http.Client();

  /// Combina les capçaleres específiques amb les globals (p.ex. x-api-key)
  /// Combina les capçaleres específiques amb les globals (p.ex. x-api-key)
  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    final merged = <String, String>{
      if (headers != null) ...headers,
      'x-api-key': apiKey?.isNotEmpty == true ? apiKey! : 'reqres-free-v1',
    };
    return merged;
  }

  /// Fa una petició GET i retorna el cos JSON decodificat.
  /// Fa una petició GET i retorna el cos JSON decodificat.
  Future<dynamic> getJson(Uri uri, {Map<String, String>? headers}) async {
    final merged = _mergeHeaders({
      'Accept':
          'application/json', // ⬅️ Afegit: evita 401 en alguns proxys/paths
      if (headers != null) ...headers,
    });
    final res = await _client.get(uri, headers: merged).timeout(timeout);
    return _handleJsonResponse(res);
  }

  /// Fa una petició POST amb cos JSON i retorna el JSON de resposta.
  Future<dynamic> postJson(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final merged = _mergeHeaders({
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    });
    final res = await _client
        .post(uri, headers: merged, body: jsonEncode(body))
        .timeout(timeout);
    return _handleJsonResponse(res);
  }

  /// Fa una petició PUT amb cos JSON i retorna el JSON de resposta.
  Future<dynamic> putJson(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final merged = _mergeHeaders({
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    });
    final res = await _client
        .put(uri, headers: merged, body: jsonEncode(body))
        .timeout(timeout);
    return _handleJsonResponse(res);
  }

  /// Fa una petició PATCH amb cos JSON i retorna el JSON de resposta.
  Future<dynamic> patchJson(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final merged = _mergeHeaders({
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    });
    final res = await _client
        .patch(uri, headers: merged, body: jsonEncode(body))
        .timeout(timeout);
    return _handleJsonResponse(res);
  }

  /// Fa una petició DELETE.
  Future<void> delete(Uri uri, {Map<String, String>? headers}) async {
    final res = await _client
        .delete(uri, headers: _mergeHeaders(headers))
        .timeout(timeout);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException(
        'DELETE ha fallat',
        statusCode: res.statusCode,
        body: res.body,
      );
    }
  }

  /// Processa la resposta i intenta decodificar el cos JSON.
  /// Llança excepció si el codi no és 2xx o si el JSON no és vàlid.
  dynamic _handleJsonResponse(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return null;
      try {
        return jsonDecode(utf8.decode(res.bodyBytes));
      } on FormatException {
        throw ApiException(
          'Resposta no és JSON vàlid',
          statusCode: res.statusCode,
          body: res.body,
        );
      }
    }
    throw ApiException(
      'Error HTTP',
      statusCode: res.statusCode,
      body: res.body,
    );
  }

  /// Tanca el client HTTP i allibera recursos.
  void close() => _client.close();
}
