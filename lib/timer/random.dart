part of 'timer.dart';

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

class RandomTimerSelector extends StatelessWidget {
  final RandomTimerStrategy strategy;
  final Callback<RandomTimerStrategy> onChanged;

  const RandomTimerSelector({
    Key key,
    this.strategy,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleChange(RangedDuration range) {
      onChanged(
        strategy.copyWith(min: range.start, max: range.end),
      );
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Drag the slider to adjust the speaking timer.'),
        ),
        DurationRangeSlider(
          value: RangedDuration(strategy.min, strategy.max),
          onChanged: onChanged != null ? handleChange : null,
        ),
        Text('${strategy.min.inMinutes} - ${strategy.max.inMinutes} minutes'),
      ],
    );
  }
}
