// Exemple amb ChangeNotifier (simplificat)
// lib/reqres/user_provider.dart
import 'package:flutter/foundation.dart';
import '../api_client.dart';
import 'reqres_api.dart';
import 'reqres_models.dart';
import '../core/pagination.dart';

class UserState with ChangeNotifier {
  final ReqResApi api;
  UserState(this.api);

  Paginated<ReqResUser>? page;
  String? error;

  Future<void> loadUsers({int pageIndex = 1}) async {
    error = null;
    notifyListeners();
    try {
      page = await api.listUsers(page: pageIndex);
    } on ApiException catch (e) {
      error = e.statusCode == 404
          ? 'No s’ha trobat la pàgina'
          : 'Error carregant usuaris (${e.statusCode})';
    } catch (_) {
      error = 'Error desconegut';
    }
    notifyListeners();
  }

  Future<ReqResUser?> loadUser(int id) async {
    try {
      return await api.getUser(id); // pot tornar null si 404
    } on ApiException catch (e) {
      error = 'Error obtenint usuari (${e.statusCode})';
      notifyListeners();
      return null;
    }
  }
}
