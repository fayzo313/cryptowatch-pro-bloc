import 'package:equatable/equatable.dart';

abstract class MarketsEvent extends Equatable {
  const MarketsEvent();
  @override
  List<Object?> get props => [];
}

class FetchMarketsEvent extends MarketsEvent {
  final bool forceRefresh;
  const FetchMarketsEvent({this.forceRefresh = false});
  @override
  List<Object?> get props => [forceRefresh];
}

class ToggleWatchlistEvent extends MarketsEvent {
  final String coinId;
  const ToggleWatchlistEvent(this.coinId);
  @override
  List<Object?> get props => [coinId];
}