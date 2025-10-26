// lib/reqres/reqres_api.dart
//
// Classe principal que encapsula totes les crides HTTP a la API pública de ReqRes.
// Gestiona usuaris (/users) i recursos (/unknown) amb maneig d'errors i models tipats.

import 'package:flutter_package_1/reqres/resources_models.dart';
import '../config/constants.dart';
import '../core/pagination.dart';
import 'reqres_models.dart';
import '../api_client.dart';

/// Client de servei per accedir a l'API de ReqRes.
/// Centralitza totes les peticions i converteix les respostes JSON en models de Dart.
class ReqResApi {
  final ApiClient _client;
  final Uri _base;

  /// Constructor principal. Permet sobreescriure la [baseUrl] per a proves.
  ReqResApi(this._client, {String? baseUrl})
      : _base = Uri.parse(baseUrl ?? ApiConfig.reqresBaseUrl);

  // ---------------------------------------------------------------------------
  // --- USERS ---
  // ---------------------------------------------------------------------------

  /// Crea un usuari a ReqRes (POST /users).
  /// Retorna el model d'eco amb `id` i `createdAt` si tot va bé.
  Future<CreatedOrUpdatedUser> createUser({
    required String name,
    required String job,
  }) async {
    final uri = _base.replace(path: '${_base.path}${ReqresPaths.users}');
    final body = {'name': name, 'job': job};

    // Enviem JSON i parsegem la resposta a CreatedOrUpdatedUser (tal com espera el test)
    final json =
        await _client.postJson(uri, body: body) as Map<String, dynamic>;
    return CreatedOrUpdatedUser.fromJson(json);
  }

  /// Obté un únic usuari pel seu [id].
  /// Retorna null si la resposta és 404 (usuari no trobat).
  Future<ReqResUser?> getUser(int id) async {
    final uri = _base.replace(path: '${_base.path}${ReqresPaths.users}/$id');
    try {
      final json = await _client.getJson(uri) as Map<String, dynamic>;
      return ReqResUser.fromJson(json['data'] as Map<String, dynamic>);
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }

  /// Obté la llista d'usuaris (GET /users?page=x).
  /// El test **espera** que això retorni un `ReqResUserList`.
  Future<ReqResUserList> listUsers({int page = 1}) async {
    final uri = _base.replace(
      path: '${_base.path}${ReqresPaths.users}',
      queryParameters: {'page': '$page'},
    );

    final json = await _client.getJson(uri) as Map<String, dynamic>;
    return ReqResUserList.fromJson(json);
  }

  // ---------------------------------------------------------------------------
  // --- RESOURCES ---
  // ---------------------------------------------------------------------------

  /// Obté la llista de recursos (colors) paginada (GET /unknown?page=x).
  Future<Paginated<ReqResResource>> listResources({int page = 1}) async {
    final uri = _base.replace(
      path: '${_base.path}${ReqresPaths.resources}',
      queryParameters: {'page': '$page'},
    );

    final json = await _client.getJson(uri) as Map<String, dynamic>;
    return Paginated<ReqResResource>.fromJson(
      json,
      (m) => ReqResResource.fromJson(m),
    );
  }

  /// Obté un recurs concret pel seu [id] (GET /unknown/{id}).
  /// Retorna null si la resposta és 404 (recurs no trobat).
  Future<ReqResResource?> getResource(int id) async {
    final uri =
        _base.replace(path: '${_base.path}${ReqresPaths.resources}/$id');
    try {
      final json = await _client.getJson(uri) as Map<String, dynamic>;
      return ReqResResource.fromJson(json['data'] as Map<String, dynamic>);
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }
}
