import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class OrderStrategy {
  T next<T>(List<T> previous, List<T> all);

  const factory OrderStrategy.fixed({List<int> order}) = FixedOrderStrategy;

  const factory OrderStrategy.random() = RandomOrderStrategy;
}

class FixedOrderStrategy extends Equatable implements OrderStrategy {
  final List<int> order;

  const FixedOrderStrategy({this.order});

  T next<T>(List<T> previous, List<T> all) {
    if (this.order != null) {
      assert(
        order.length == all.length,
        'Preferred fixed order does not match given array length',
      );
      return all[order[previous.length]];
    }

    return all[previous.length];
  }

  @override
  List<Object> get props => [order];
}

class RandomOrderStrategy extends Equatable implements OrderStrategy {
  const RandomOrderStrategy();

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
