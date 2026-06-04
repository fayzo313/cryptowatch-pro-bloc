import 'package:bloc_app/core/services/dependecy_injecrtion.dart';
import 'package:bloc_app/features/markets/presentation/screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/markets_bloc.dart';
import '../bloc/markets_event.dart';
import '../bloc/markets_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext widgetContext) {
    return BlocProvider(
      create: (_) => sl<MarketsBloc>()..add(const FetchMarketsEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          title: const Text('CryptoPulse Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF1E1E1E),
          elevation: 0,
        ),
        body: BlocBuilder<MarketsBloc, MarketsState>(
          builder: (context, state) {
            if (state is MarketsLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
            } else if (state is MarketsLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MarketsBloc>().add(const FetchMarketsEvent(forceRefresh: true));
                },
                child: ListView.builder(
                  itemCount: state.coins.length,
                  itemExtent: 82.0, // Fixed pixel scope optimizes rendering
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (listViewContext, index) {
                    final coin = state.coins[index];
                    final isPositive = coin.priceChangePercentage24h >= 0;
                    
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.network(coin.imageUrl, errorBuilder: (_, __, ___) => const Icon(Icons.monetization_on)),
                      ),
                      title: Text(coin.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      subtitle: Text(coin.symbol, style: const TextStyle(color: Colors.grey)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$${coin.currentPrice.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text(
                            '${isPositive ? '+' : ''}${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                            style: TextStyle(color: isPositive ? Colors.greenAccent : Colors.redAccent, fontSize: 13),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          listViewContext,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<MarketsBloc>(),
                              child: DetailScreen(coinId: coin.id),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is MarketsError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}