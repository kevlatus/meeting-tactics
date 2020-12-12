import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class OrderStrategy {
  T next<T>(List<T> previous, List<T> all);

  const factory OrderStrategy.fixed() = _FixedOrderStrategy;

  const factory OrderStrategy.random() = _RandomOrderStrategy;
}

class _FixedOrderStrategy extends Equatable implements OrderStrategy {
  const _FixedOrderStrategy();

  T next<T>(List<T> previous, List<T> all) {
    return all[previous.length];
  }

  @override
  List<Object> get props => [];
}

class _RandomOrderStrategy extends Equatable implements OrderStrategy {
  const _RandomOrderStrategy();

  @override
  T next<T>(List<T> previous, List<T> all) {
    final missingItems = [
      for (var it in all)
        if (!previous.contains(it)) it
    ];
    final rng = Random();
    return missingItems[rng.nextInt(missingItems.length)];
  }

  @override
  List<Object> get props => [];
}
