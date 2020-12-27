part of 'speaker_view.dart';

class BarSpeakerView extends StatelessWidget {
  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;
  final StepperDirection direction;

  const BarSpeakerView({
    Key key,
    this.selected,
    this.attendees,
    this.unavailableAttendees,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FortuneBar(
      selected: selected,
      onAnimationStart: onAnimationStart,
      onAnimationEnd: onAnimationEnd,
      fullWidth: true,
      items: [
        for (var it in attendees) FortuneItem(child: Text(it)),
      ],
    );
  }
}
