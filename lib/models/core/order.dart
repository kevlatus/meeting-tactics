import 'package:equatable/equatable.dart';

abstract class OrderStrategy {
  T next<T>(List<T> previous, List<T> all);

  const factory OrderStrategy.fixed() = _FixedOrderStrategy;
}

class _FixedOrderStrategy extends Equatable implements OrderStrategy {
  const _FixedOrderStrategy();

  T next<T>(List<T> previous, List<T> all) {
    return all[previous.length];
  }

  @override
  List<Object> get props => [];
}
