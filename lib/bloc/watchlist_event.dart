import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {}

class ReorderStock extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderStock(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class RemoveStock extends WatchlistEvent {
  final int index;

  const RemoveStock(this.index);

  @override
  List<Object?> get props => [index];
}
