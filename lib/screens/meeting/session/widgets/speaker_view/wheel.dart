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
    final animationType = direction == StepperDirection.Backward
        ? FortuneAnimation.None
        : FortuneAnimation.Spin;

    return FortuneWheel(
      selected: selected ?? 0,
      animationType: animationType,
      onAnimationStart: onAnimationStart,
      onAnimationEnd: onAnimationEnd,
      items: [
        for (String attendee in attendees) FortuneItem(child: Text(attendee))
      ],
    );
  }
}
