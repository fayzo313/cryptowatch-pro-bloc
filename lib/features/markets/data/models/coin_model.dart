import 'dart:convert';
import '../../domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  const CoinModel({
    required super.id,
    required super.name,
    required super.symbol,
    required super.imageUrl,
    required super.currentPrice,
    required super.priceChangePercentage24h,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbol: (json['symbol'] ?? '').toString().toUpperCase(),
      imageUrl: json['image'] ?? '',
      currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static List<CoinModel> fromRawJsonList(String rawString) {
    final List<dynamic> decoded = json.decode(rawString);
    return decoded.map((item) => CoinModel.fromJson(item)).toList();
  }
}