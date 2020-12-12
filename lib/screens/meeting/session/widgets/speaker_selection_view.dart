import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpeakerSelectionView extends StatelessWidget {
  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;

  const SpeakerSelectionView({
    Key key,
    @required this.attendees,
    this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.unavailableAttendees = const <String>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected == null) {
      return Container();
    }

    return _FortuneWheelSpeakerSelection(
      selected: selected,
      attendees: attendees,
      onAnimationStart: onAnimationStart,
      onAnimationEnd: onAnimationEnd,
      unavailableAttendees: unavailableAttendees,
    );
  }
}

class _FortuneWheelSpeakerSelection extends StatelessWidget {
  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;

  const _FortuneWheelSpeakerSelection({
    Key key,
    @required this.attendees,
    @required this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.unavailableAttendees = const <String>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 512,
        maxHeight: 512,
      ),
      child: SizedBox.expand(
        child: FortuneWheel(
          selected: selected < 0 ? 0 : selected,
          onAnimationStart: onAnimationStart,
          onAnimationEnd: onAnimationEnd,
          slices: [
            for (String attendee in attendees)
              CircleSlice(
                fillColor: unavailableAttendees.contains(attendee)
                    ? Colors.grey.shade400
                    : null,
                strokeColor: unavailableAttendees.contains(attendee)
                    ? Colors.grey.shade600
                    : null,
                child: Text(attendee),
              )
          ],
        ),
      ),
    );
  }
}
