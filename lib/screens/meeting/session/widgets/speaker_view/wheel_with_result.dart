part of 'speaker_view.dart';

class WheelWithResultSpeakerView extends HookWidget {
  static const Interval _kRollInterval = const Interval(0, 0.7);

  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;
  final StepperDirection direction;

  const WheelWithResultSpeakerView({
    Key key,
    @required this.attendees,
    @required this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.unavailableAttendees = const <String>[],
    this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationCtrl = useAnimationController(
      duration: Duration(milliseconds: 500),
    );

    useValueChanged(selected, (_, __) {
      animationCtrl.reverse(from: _kRollInterval.end);
    });

    final rollAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: _kRollInterval,
      ),
    );
    final resultAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: Interval(_kRollInterval.end, 1),
      ),
    );

    final curve = direction == StepperDirection.Backward
        ? FortuneCurve.none
        : FortuneCurve.spin;

    final textAngle = randomInRange(-0.4, 0.4);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: animationCtrl,
          builder: (context, _) {
            return Transform.scale(
              scale: resultAnimation.value,
              child: Transform.rotate(
                angle: textAngle,
                child: CircledBox(
                  child: Text(
                    attendees[selected],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: animationCtrl,
          builder: (context, _) {
            return Transform.scale(
              scale: rollAnimation.value,
              child: FortuneWheel(
                selected: selected,
                curve: curve,
                onAnimationStart: onAnimationStart,
                onAnimationEnd: () async {
                  animationCtrl.forward();
                  if (onAnimationEnd != null) {
                    onAnimationEnd();
                  }
                },
                items: [
                  for (String attendee in attendees)
                    FortuneItem(child: Text(attendee))
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
