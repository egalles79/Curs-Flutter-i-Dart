/// Model per respostes de creació/actualització d'usuari a ReqRes.
/// - POST /users → createdAt
/// - PUT/PATCH /users/{id} → updatedAt
class ReqResCreatedUser {
  final String name;
  final String job;
  final String id;
  final DateTime? createdAt; // pot ser null en updates
  final DateTime? updatedAt; // pot ser null en creates

  ReqResCreatedUser({
    required this.name,
    required this.job,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  /// Getter comú que entrega updatedAt si existeix, altrament createdAt.
  /// Si cap és present, retorna un DateTime d'epoch (evita nulls als prints).
  DateTime get updatedAtOrCreatedAt =>
      updatedAt ?? createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  factory ReqResCreatedUser.fromJson(Map<String, dynamic> json) {
    final created = json['createdAt'] as String?;
    final updated = json['updatedAt'] as String?;
    return ReqResCreatedUser(
      name: json['name'] as String? ?? '',
      job: json['job'] as String? ?? '',
      id: json['id'] as String? ?? '',
      createdAt: created != null ? DateTime.parse(created) : null,
      updatedAt: updated != null ? DateTime.parse(updated) : null,
    );
  }
}
