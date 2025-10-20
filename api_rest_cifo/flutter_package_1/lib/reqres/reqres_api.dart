import '../api_client.dart';
import 'reqres_models.dart';

/// Client per a l'API de ReqRes (mock API públic)
class ReqResApi {
  final ApiClient _client;
  final Uri _base;

  ReqResApi(ApiClient client, {String baseUrl = 'https://reqres.in/api'})
      : _client = client,
        _base = Uri.parse(baseUrl);

  /// Llista d'usuaris amb paginació. [page] comença en 1.
  Future<ReqResUserList> listUsers({int page = 1}) async {
    final uri = _base.replace(path: '${_base.path}/users', queryParameters: {
      'page': '$page',
    });
    final json = await _client.getJson(uri);
    return ReqResUserList.fromJson(json as Map<String, dynamic>);
  }

  /// Obté un usuari pel seu [id].
  Future<ReqResUser> getUser(int id) async {
    final uri = _base.replace(path: '${_base.path}/users/$id');
    final json = await _client.getJson(uri);
    return ReqResUser.fromJson((json as Map<String, dynamic>)['data']);
  }

  /// Crea un usuari (mock). Retorna info d'eco + id.
  Future<CreatedOrUpdatedUser> createUser({
    required String name,
    required String job,
  }) async {
    final uri = _base.replace(path: '${_base.path}/users');
    final json = await _client.postJson(uri, body: {'name': name, 'job': job});
    return CreatedOrUpdatedUser.fromJson(json as Map<String, dynamic>);
  }

  /// Actualitza un usuari (PATCH).
  Future<CreatedOrUpdatedUser> updateUser({
    required int id,
    required String name,
    required String job,
  }) async {
    final uri = _base.replace(path: '${_base.path}/users/$id');
    final json = await _client.patchJson(uri, body: {'name': name, 'job': job});
    return CreatedOrUpdatedUser.fromJson(json as Map<String, dynamic>);
  }

  /// Esborra un usuari. (204 No Content si va bé)
  Future<void> deleteUser(int id) async {
    final uri = _base.replace(path: '${_base.path}/users/$id');
    await _client.delete(uri);
  }

  /// Login (mock). Retorna token.
  Future<ReqResAuth> login({
    required String email,
    required String password,
  }) async {
    final uri = _base.replace(path: '${_base.path}/login');
    final json = await _client
        .postJson(uri, body: {'email': email, 'password': password});
    return ReqResAuth.fromJson(json as Map<String, dynamic>);
  }

  /// Register (mock). Retorna token.
  Future<ReqResAuth> register({
    required String email,
    required String password,
  }) async {
    final uri = _base.replace(path: '${_base.path}/register');
    final json = await _client
        .postJson(uri, body: {'email': email, 'password': password});
    return ReqResAuth.fromJson(json as Map<String, dynamic>);
  }
}
