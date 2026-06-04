import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;
  static const String _watchlistKey = 'watchlist_coins';
  static const String _cacheKey = 'cached_market_data';

  LocalStorageService(this._prefs);

  // Watchlist Persistent Caching
  List<String> getWatchlist() {
    return _prefs.getStringList(_watchlistKey) ?? [];
  }

  Future<void> toggleWatchlist(String coinId) async {
    final currentList = getWatchlist();
    if (currentList.contains(coinId)) {
      currentList.remove(coinId);
    } else {
      currentList.add(coinId);
    }
    await _prefs.setStringList(_watchlistKey, currentList);
  }

  // Raw API Response offline caching
  Future<void> cacheMarketData(String jsonRaw) async {
    await _prefs.setString(_cacheKey, jsonRaw);
  }

  String? getCachedMarketData() {
    return _prefs.getString(_cacheKey);
  }
}