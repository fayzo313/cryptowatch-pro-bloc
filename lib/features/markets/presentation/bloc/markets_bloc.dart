import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/coin_repository.dart';
import 'markets_event.dart';
import 'markets_state.dart';

class MarketsBloc extends Bloc<MarketsEvent, MarketsState> {
  final CoinRepository repository;

  MarketsBloc({required this.repository}) : super(MarketsInitial()) {
    on<FetchMarketsEvent>(_onFetchMarkets);
    on<ToggleWatchlistEvent>(_onToggleWatchlist);
  }

  Future<void> _onFetchMarkets(FetchMarketsEvent event, Emitter<MarketsState> emit) async {
    if (!event.forceRefresh) emit(MarketsLoading());
    try {
      final coins = await repository.getMarketCoins(forceRefresh: event.forceRefresh);
      emit(MarketsLoaded(coins));
    } catch (e) {
      emit(const MarketsError("Failed to synchronize market data."));
    }
  }

  Future<void> _onToggleWatchlist(ToggleWatchlistEvent event, Emitter<MarketsState> emit) async {
    if (state is MarketsLoaded) {
      final currentCoins = (state as MarketsLoaded).coins;
      final updatedCoins = await repository.toggleWatchlistStatus(event.coinId, currentCoins);
      emit(MarketsLoaded(updatedCoins));
    }
  }
}