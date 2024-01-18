class Crypto {
  final String id;
  final String name;
  final String symbol;
  final String supply;
  final String? maxSupply;
  final String marketCapUsd;
  final String volumeUsd24Hr;
  final String priceUsd;
  final String changePercent24Hr;
  final String? vwap24Hr;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.supply,
    this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.changePercent24Hr,
    this.vwap24Hr,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      supply: json['supply'],
      maxSupply: json['maxSupply'],
      marketCapUsd: json['marketCapUsd'],
      volumeUsd24Hr: json['volumeUsd24Hr'],
      priceUsd: json['priceUsd'],
      changePercent24Hr: json['changePercent24Hr'],
      vwap24Hr: json['vwap24Hr'],
    );
  }
}
