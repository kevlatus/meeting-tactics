part of 'timer.dart';

class NoTimerStrategy extends Equatable implements TimerStrategy {
  const NoTimerStrategy();

  @override
  Duration getTimer(int index) => null;

  @override
  List<Object> get props => [];
}
