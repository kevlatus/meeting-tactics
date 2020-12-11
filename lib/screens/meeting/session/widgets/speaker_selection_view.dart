import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpeakerSelectionView extends StatelessWidget {
  final int selected;
  final List<String> attendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;

  const SpeakerSelectionView({
    Key key,
    this.attendees,
    this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
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
    );
  }
}

class _FortuneWheelSpeakerSelection extends StatelessWidget {
  final int selected;
  final List<String> attendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;

  const _FortuneWheelSpeakerSelection({
    Key key,
    @required this.attendees,
    @required this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
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
          slices: attendees
              .map(
                (e) => CircleSlice(
                  child: Text(e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
