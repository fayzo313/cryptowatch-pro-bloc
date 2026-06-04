import '../../domain/entities/coin_entity.dart';

abstract class CoinRepository {
  Future<List<CoinEntity>> getMarketCoins({bool forceRefresh = false});
  Future<List<CoinEntity>> toggleWatchlistStatus(String coinId, List<CoinEntity> currentList);
}