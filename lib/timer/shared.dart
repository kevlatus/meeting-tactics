part of 'timer.dart';

abstract class TimerStrategy {
  Duration getTimer(int index);
}

class TimerStrategySelector extends StatelessWidget {
  final TimerStrategy selected;
  final Callback<TimerStrategy> onChanged;

  const TimerStrategySelector({
    Key key,
    this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextToggleButtons<TimerStrategy>(
      selected: selected,
      matcher: (v) => v.runtimeType == selected.runtimeType,
      items: [
        IconTextToggleButton(
          icon: Icon(Icons.cancel),
          text: 'No timer',
          value: NoTimerStrategy(),
        ),
        IconTextToggleButton(
          icon: Icon(Icons.linear_scale),
          text: 'Fixed',
          value: FixedTimerStrategy.single(duration: Duration(minutes: 3)),
        ),
        IconTextToggleButton(
          icon: Icon(Icons.shuffle),
          text: 'Random',
          value: RandomTimerStrategy(
            min: Duration(minutes: 3),
            max: Duration(minutes: 6),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
