import 'dart:convert';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/coin_entity.dart';
import '../../domain/repositories/coin_repository.dart';
import '../models/coin_model.dart';

class CoinRepositoryImpl implements CoinRepository {
  final ApiClient apiClient;
  final LocalStorageService storageService;

  CoinRepositoryImpl({required this.apiClient, required this.storageService});

  @override
  Future<List<CoinEntity>> getMarketCoins({bool forceRefresh = false}) async {
    final watchlist = storageService.getWatchlist();

    if (!forceRefresh) {
      final cachedJson = storageService.getCachedMarketData();
      if (cachedJson != null) {
        final models = CoinModel.fromRawJsonList(cachedJson);
        return _mapWatchlistStatus(models, watchlist);
      }
    }

    try {
      final response = await apiClient.dio.get(
        ApiConstants.marketsEndpoint,
        queryParameters: {
          'vs_currency': ApiConstants.currencyUsd,
          'order': 'market_cap_desc',
          'per_page': ApiConstants.perPageLimit,
          'page': 1,
        },
      );

      if (response.statusCode == 200) {
        final rawJson = json.encode(response.data);
        await storageService.cacheMarketData(rawJson);
        
        final List<dynamic> list = response.data;
        final models = list.map((item) => CoinModel.fromJson(item)).toList();
        return _mapWatchlistStatus(models, watchlist);
      }
      throw Exception();
    } catch (e) {
      // Return local cache if endpoint connection throws exception
      final cachedJson = storageService.getCachedMarketData();
      if (cachedJson != null) {
        return _mapWatchlistStatus(CoinModel.fromRawJsonList(cachedJson), watchlist);
      }
      rethrow;
    }
  }

  @override
  Future<List<CoinEntity>> toggleWatchlistStatus(String coinId, List<CoinEntity> currentList) async {
    await storageService.toggleWatchlist(coinId);
    final updatedWatchlist = storageService.getWatchlist();
    return currentList.map((coin) {
      return coin.id == coinId 
          ? coin.copyWith(isWatchlisted: updatedWatchlist.contains(coinId))
          : coin;
    }).toList();
  }

  List<CoinEntity> _mapWatchlistStatus(List<CoinModel> coins, List<String> watchlistIds) {
    return coins.map((coin) {
      return coin.copyWith(isWatchlisted: watchlistIds.contains(coin.id));
    }).toList();
  }
}