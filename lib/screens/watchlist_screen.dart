import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_state.dart';
import '../models/stock.dart';
import 'edit_watchlist_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            _buildIndexItem('SENSEX 18TH SEP 8...', 'BSE', '1,225.55', '144.50 (13.3...', true),
            const SizedBox(width: 8),
            Container(width: 1, height: 30, color: Colors.grey[300]),
            const SizedBox(width: 8),
            _buildIndexItem('NIFTY BANK', '', '54,168.50', '-18.40 (-0.03...', false),
            const Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for instruments',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          _buildTabs(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                ActionChip(
                  avatar: const Icon(Icons.tune, size: 16),
                  label: const Text('Sort by'),
                  onPressed: () {},
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: BorderSide.none,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                if (state is WatchlistLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WatchlistLoaded) {
                  return ListView.separated(
                    itemCount: state.stocks.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final stock = state.stocks[index];
                      return _buildStockItem(context, stock);
                    },
                  );
                } else if (state is WatchlistError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Empty Watchlist'));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on_outlined), label: 'GTT+'),
          BottomNavigationBarItem(icon: Icon(Icons.business_center_outlined), label: 'Portfolio'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Funds'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildIndexItem(String title, String exchange, String price, String change, bool isPositive) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              if (exchange.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(exchange, style: const TextStyle(fontSize: 9, color: Colors.grey)),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(price, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Flexible(child: Text(change, style: TextStyle(fontSize: 9, color: isPositive ? Colors.green : Colors.red), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              const Text('Watchlist 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Container(height: 2, width: 60, color: Colors.black),
            ],
          ),
          const SizedBox(width: 24),
          const Text('Watchlist 5', style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(width: 24),
          const Text('Watchlist 6', style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildStockItem(BuildContext context, Stock stock) {
    return InkWell(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditWatchlistScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stock.symbol, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(stock.name, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: stock.change >= 0 ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${stock.change >= 0 ? '+' : ''}${stock.change.toStringAsFixed(2)} (${stock.percentChange.toStringAsFixed(2)}%)',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
