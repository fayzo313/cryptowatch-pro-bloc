import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double currentPrice;
  final double priceChangePercentage24h;
  final bool isWatchlisted;

  const CoinEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    this.isWatchlisted = false,
  });

  CoinEntity copyWith({bool? isWatchlisted}) {
    return CoinEntity(
      id: id,
      name: name,
      symbol: symbol,
      imageUrl: imageUrl,
      currentPrice: currentPrice,
      priceChangePercentage24h: priceChangePercentage24h,
      isWatchlisted: isWatchlisted ?? this.isWatchlisted,
    );
  }

  @override
  List<Object?> get props => [id, name, symbol, imageUrl, currentPrice, priceChangePercentage24h, isWatchlisted];
}