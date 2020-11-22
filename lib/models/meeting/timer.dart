import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SpeakerTimer<T> extends Equatable {
  const SpeakerTimer();

  String get label;

  T get options;

  SpeakerTimer<T> copyWith({T options});
}

class NoTimer extends SpeakerTimer<void> {
  final String label = 'No Timer';
  final void options = null;

  const NoTimer();

  NoTimer copyWith({void options}) => this;

  @override
  List<Object> get props => [label];
}

class FixedDurationTimer extends SpeakerTimer<Duration> {
  final String label = 'Fixed Duration';
  final Duration options;

  const FixedDurationTimer({
    this.options = const Duration(minutes: 3),
  });

  FixedDurationTimer copyWith({Duration options}) =>
      FixedDurationTimer(options: options ?? this.options);

  @override
  List<Object> get props => [label, options];
}

class DurationRange extends Equatable {
  final Duration min;
  final Duration max;

  const DurationRange({
    @required this.min,
    @required this.max,
  });

  @override
  List<Object> get props => [min, max];
}

class RandomDurationTimer extends SpeakerTimer<DurationRange> {
  final String label = 'Random Duration';
  final DurationRange options;

  const RandomDurationTimer({
    this.options = const DurationRange(
      min: Duration(minutes: 2),
      max: Duration(minutes: 5),
    ),
  });

  RandomDurationTimer copyWith({DurationRange options}) =>
      RandomDurationTimer(options: options ?? this.options);

  @override
  List<Object> get props => [label, options];
}
