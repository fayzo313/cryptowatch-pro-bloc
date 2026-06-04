import 'package:equatable/equatable.dart';
import '../../domain/entities/coin_entity.dart';

abstract class MarketsState extends Equatable {
  const MarketsState();
  @override
  List<Object?> get props => [];
}

class MarketsInitial extends MarketsState {}
class MarketsLoading extends MarketsState {}

class MarketsLoaded extends MarketsState {
  final List<CoinEntity> coins;
  const MarketsLoaded(this.coins);
  @override
  List<Object?> get props => [coins];
}

class MarketsError extends MarketsState {
  final String message;
  const MarketsError(this.message);
  @override
  List<Object?> get props => [message];
}