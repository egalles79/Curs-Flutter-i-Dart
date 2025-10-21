// lib/core/pagination.dart
// Model genèric de pàgina paginada de ReqRes
class Paginated<T> {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<T> data;

  Paginated({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  // fromJson genèric amb un "itemFromJson" per cada tipus T
  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) itemFromJson,
  ) {
    final list = (json['data'] as List<dynamic>? ?? [])
        .map((e) => itemFromJson(e as Map<String, dynamic>))
        .toList();

    return Paginated<T>(
      page: (json['page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      data: list,
    );
  }
}
