// lib/reqres/resource_models.dart
// Model de recurs "color" de ReqRes.
class ReqResResource {
  final int id;
  final String name;
  final int year;
  final String color; // ex: "#98B2D1"
  final String pantoneValue; // ex: "15-4020"

  ReqResResource({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });

  factory ReqResResource.fromJson(Map<String, dynamic> json) => ReqResResource(
        id: (json['id'] as num).toInt(),
        name: json['name'] as String,
        year: (json['year'] as num).toInt(),
        color: json['color'] as String,
        pantoneValue: json['pantone_value'] as String,
      );
}

class ReqResResourceList {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<ReqResResource> data;

  ReqResResourceList({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory ReqResResourceList.fromJson(Map<String, dynamic> json) =>
      ReqResResourceList(
        page: (json['page'] as num).toInt(),
        perPage: (json['per_page'] as num).toInt(),
        total: (json['total'] as num).toInt(),
        totalPages: (json['total_pages'] as num).toInt(),
        data: (json['data'] as List<dynamic>)
            .map((e) => ReqResResource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
