import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meet/callbacks.dart';

class DurationSlider extends StatelessWidget {
  final Duration value;
  final Callback<Duration> onChanged;

  const DurationSlider({
    Key key,
    this.value = const Duration(minutes: 3),
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = value.inMinutes;

    return Slider(
      value: minutes.toDouble(),
      onChanged: (v) {
        if (onChanged == null) return;
        onChanged(Duration(minutes: v.toInt()));
      },
      min: 1,
      max: 30,
      divisions: 29,
    );
  }
}

class RangedDuration extends Equatable {
  final Duration start;
  final Duration end;

  RangedDuration(this.start, this.end);

  @override
  List<Object> get props => [start, end];
}

class DurationRangeSlider extends StatelessWidget {
  final RangedDuration value;
  final Callback<RangedDuration> onChanged;

  const DurationRangeSlider({
    Key key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: RangeValues(
        value.start.inMinutes.toDouble(),
        value.end.inMinutes.toDouble(),
      ),
      min: 1,
      max: 30,
      divisions: 29,
      onChanged: (v) {
        if (onChanged == null) return;
        onChanged(RangedDuration(
          Duration(minutes: v.start.toInt()),
          Duration(minutes: v.end.toInt()),
        ));
      },
    );
  }
}
