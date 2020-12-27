part of 'timer.dart';

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

  Duration get first => durations.first;

  FixedTimerStrategy copyWith({List<Duration> durations}) =>
      FixedTimerStrategy._(durations ?? this.durations);

  @override
  List<Object> get props => [durations];
}

class FixedTimerSelector extends StatelessWidget {
  final FixedTimerStrategy strategy;
  final Callback<FixedTimerStrategy> onChanged;

  const FixedTimerSelector({
    Key key,
    this.strategy,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleChange(Duration duration) {
      onChanged(strategy.copyWith(durations: [duration]));
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Drag the slider to adjust the speaking timer.'),
        ),
        DurationSlider(
          value: strategy.first,
          onChanged: onChanged != null ? handleChange : null,
        ),
        Text('${strategy.first.inMinutes} minutes'),
      ],
    );
  }
}
