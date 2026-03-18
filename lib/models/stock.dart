import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final String name;
  final String exchange;
  final double price;
  final double change;
  final double percentChange;
  final String? type; // e.g., "Monthly", "EQ", "IDX"

  const Stock({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.percentChange,
    this.type,
  });

  @override
  List<Object?> get props => [symbol, name, exchange, price, change, percentChange, type];

  Stock copyWith({
    String? symbol,
    String? name,
    String? exchange,
    double? price,
    double? change,
    double? percentChange,
    String? type,
  }) {
    return Stock(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      exchange: exchange ?? this.exchange,
      price: price ?? this.price,
      change: change ?? this.change,
      percentChange: percentChange ?? this.percentChange,
      type: type ?? this.type,
    );
  }
}
