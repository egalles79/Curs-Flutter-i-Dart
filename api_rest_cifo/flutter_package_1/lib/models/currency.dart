// lib/models/currency.dart
// Comentaris en català: model per representar una moneda segons la API RestCountries.

class Currency {
  final String name;
  final String symbol;

  Currency({required this.name, required this.symbol});

  /// A RestCountries v3.1 les monedes són un Map:
  /// "currencies": {"PEN": {"name": "Peruvian sol", "symbol": "S/"}}
  /// A v2 són una llista: [{"code":"PEN","name":"Peruvian sol","symbol":"S/"}]
  factory Currency.fromJson(Map<String, dynamic> json) {
    final n = json['name'];
    final name = n is String
        ? n
        : (n is Map<String, dynamic>
            ? (n['common'] ?? n['official'] ?? n['name'] ?? '')
            : '');
    final symbol = (json['symbol'] ?? '') as String;
    return Currency(name: name, symbol: symbol);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'symbol': symbol,
      };
}
