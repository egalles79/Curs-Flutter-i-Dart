// Models per a ReqRes (https://reqres.in/)
// Comentaris en català, concisos i útils.

class ReqResUser {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  ReqResUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory ReqResUser.fromJson(Map<String, dynamic> json) => ReqResUser(
    id: json['id'] as int,
    email: json['email'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    avatar: json['avatar'] as String,
  );
}

class ReqResSupport {
  final String url;
  final String text;

  ReqResSupport({required this.url, required this.text});

  factory ReqResSupport.fromJson(Map<String, dynamic> json) =>
      ReqResSupport(url: json['url'] as String, text: json['text'] as String);
}

class ReqResUserList {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<ReqResUser> data;
  final ReqResSupport support;

  ReqResUserList({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory ReqResUserList.fromJson(Map<String, dynamic> json) => ReqResUserList(
    page: json['page'] as int,
    perPage: json['per_page'] as int,
    total: json['total'] as int,
    totalPages: json['total_pages'] as int,
    data: (json['data'] as List<dynamic>)
        .map((e) => ReqResUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    support: ReqResSupport.fromJson(json['support']),
  );
}

class CreatedOrUpdatedUser {
  // Resposta de create/update (ReqRes fa d'eco)
  final String name;
  final String job;
  final String? id; // només a create
  final DateTime updatedAtOrCreatedAt;

  CreatedOrUpdatedUser({
    required this.name,
    required this.job,
    required this.id,
    required this.updatedAtOrCreatedAt,
  });

  factory CreatedOrUpdatedUser.fromJson(Map<String, dynamic> json) {
    // la clau pot ser "createdAt" o "updatedAt"
    final stamp = (json['createdAt'] ?? json['updatedAt']) as String;
    return CreatedOrUpdatedUser(
      name: json['name'] as String,
      job: json['job'] as String,
      id: json['id'] as String?,
      updatedAtOrCreatedAt: DateTime.parse(stamp),
    );
  }
}

class ReqResAuth {
  final String token;

  ReqResAuth(this.token);

  factory ReqResAuth.fromJson(Map<String, dynamic> json) =>
      ReqResAuth(json['token'] as String);
}
