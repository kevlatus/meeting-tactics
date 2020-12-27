import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

abstract class TimerStrategy {
  Duration getTimer(int index);
}

class NoTimerStrategy extends Equatable implements TimerStrategy {
  const NoTimerStrategy();

  @override
  Duration getTimer(int index) => null;

  @override
  List<Object> get props => [];
}

class FixedTimerStrategy extends Equatable implements TimerStrategy {
  final List<Duration> durations;

  const FixedTimerStrategy._(this.durations)
      : assert(durations != null && durations.length > 0);

  FixedTimerStrategy.single({@required Duration duration})
      : this._(<Duration>[duration]);

  const FixedTimerStrategy.multi({
    @required List<Duration> durations,
  }) : this._(durations);

  @override
  Duration getTimer(int index) {
    assert(durations.length > index);

    if (durations.length == 1) {
      return durations.first;
    } else {
      return durations[index];
    }
  }

  FixedTimerStrategy copyWith({List<Duration> durations}) =>
      FixedTimerStrategy._(durations ?? this.durations);

  @override
  List<Object> get props => [durations];
}

class RandomTimerStrategy extends Equatable implements TimerStrategy {
  final Duration min;
  final Duration max;

  const RandomTimerStrategy({
    @required this.min,
    @required this.max,
  });

  @override
  Duration getTimer(int index) {
    return Fortune.randomDuration(min, max);
  }

  RandomTimerStrategy copyWith({Duration min, Duration max}) =>
      RandomTimerStrategy(
        min: min ?? this.min,
        max: max ?? this.max,
      );

  @override
  List<Object> get props => [min, max];
}
