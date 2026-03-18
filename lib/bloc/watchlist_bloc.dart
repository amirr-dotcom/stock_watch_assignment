import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/stock.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderStock>(_onReorderStock);
    on<RemoveStock>(_onRemoveStock);
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoading());
    // Sample data structure representing stocks
    final stocks = [
      const Stock(
        symbol: 'RELIANCE SEP 1370 PE',
        name: 'NSE | Monthly',
        exchange: 'NSE',
        price: 19.20,
        change: 1.00,
        percentChange: 5.49,
        type: 'Monthly',
      ),
      const Stock(
        symbol: 'HDFCBANK',
        name: 'NSE | EQ',
        exchange: 'NSE',
        price: 966.85,
        change: 0.85,
        percentChange: 0.10,
        type: 'EQ',
      ),
      const Stock(
        symbol: 'ASIANPAINT',
        name: 'NSE | EQ',
        exchange: 'NSE',
        price: 2537.40,
        change: 6.60,
        percentChange: 0.26,
        type: 'EQ',
      ),
      const Stock(
        symbol: 'RELIANCE SEP 1880 CE',
        name: 'NSE | Monthly',
        exchange: 'NSE',
        price: 0.00,
        change: 0.00,
        percentChange: 0.00,
        type: 'Monthly',
      ),
      const Stock(
        symbol: 'RELIANCE',
        name: 'NSE | EQ',
        exchange: 'NSE',
        price: 1374.00,
        change: -4.50,
        percentChange: -0.33,
        type: 'EQ',
      ),
      const Stock(
        symbol: 'NIFTY IT',
        name: 'IDX',
        exchange: 'IDX',
        price: 35181.95,
        change: 871.51,
        percentChange: 2.54,
        type: 'IDX',
      ),
      const Stock(
        symbol: 'MRF',
        name: 'NSE | EQ',
        exchange: 'NSE',
        price: 147625.00,
        change: 550.00,
        percentChange: 0.37,
        type: 'EQ',
      ),
      const Stock(
        symbol: 'MRF',
        name: 'BSE | EQ',
        exchange: 'BSE',
        price: 147439.45,
        change: 463.80,
        percentChange: 0.32,
        type: 'EQ',
      ),
    ];
    emit(WatchlistLoaded(stocks));
  }

  void _onReorderStock(ReorderStock event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final stocks = List<Stock>.from((state as WatchlistLoaded).stocks);
      int newIndex = event.newIndex;
      if (event.oldIndex < event.newIndex) {
        newIndex -= 1;
      }
      final Stock item = stocks.removeAt(event.oldIndex);
      stocks.insert(newIndex, item);
      emit(WatchlistLoaded(stocks));
    }
  }

  void _onRemoveStock(RemoveStock event, Emitter<WatchlistState> emit) {
    if (state is WatchlistLoaded) {
      final stocks = List<Stock>.from((state as WatchlistLoaded).stocks);
      stocks.removeAt(event.index);
      emit(WatchlistLoaded(stocks));
    }
  }
}
