part of 'speaker_view.dart';

class WheelSpeakerView extends HookWidget {
  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;
  final StepperDirection direction;

  const WheelSpeakerView({
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
    final curve = direction == StepperDirection.Backward
        ? FortuneCurve.none
        : FortuneCurve.spin;

    return FortuneWheel(
      selected: selected ?? 0,
      curve: curve,
      onAnimationStart: onAnimationStart,
      onAnimationEnd: onAnimationEnd,
      duration: direction == StepperDirection.Forward
          ? Duration(seconds: 3)
          : Duration.zero,
      items: [
        for (String attendee in attendees) FortuneItem(child: Text(attendee))
      ],
    );
  }
}
