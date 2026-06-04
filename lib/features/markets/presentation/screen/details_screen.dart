import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/markets_bloc.dart';
import '../bloc/markets_event.dart';
import '../bloc/markets_state.dart';

class DetailScreen extends StatelessWidget {
  final String coinId;
  const DetailScreen({super.key, required this.coinId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Asset Deep Dive'),
      ),
      body: BlocBuilder<MarketsBloc, MarketsState>(
        builder: (context, state) {
          if (state is MarketsLoaded) {
            final coin = state.coins.firstWhere((element) => element.id == coinId);
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.network(coin.imageUrl, height: 100, width: 100),
                  const SizedBox(height: 16),
                  Text(coin.name, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  Text(coin.symbol, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Market Valuation', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        Text('\$${coin.currentPrice.toStringAsFixed(2)}', style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: coin.isWatchlisted ? Colors.redAccent : Colors.greenAccent,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: Icon(coin.isWatchlisted ? Icons.bookmark_remove : Icons.bookmark_add, color: Colors.black),
                    label: Text(
                      coin.isWatchlisted ? 'Remove from Watchlist' : 'Add to Watchlist',
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      context.read<MarketsBloc>().add(ToggleWatchlistEvent(coin.id));
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}