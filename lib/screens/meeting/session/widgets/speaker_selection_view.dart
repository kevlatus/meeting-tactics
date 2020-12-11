import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpeakerSelectionView extends StatelessWidget {
  final int selected;
  final List<String> attendees;

  const SpeakerSelectionView({
    Key key,
    this.attendees,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _FortuneWheelSpeakerSelection(
      selected: selected ?? 0,
      attendees: attendees,
    );
  }
}

class _FortuneWheelSpeakerSelection extends StatelessWidget {
  final int selected;
  final List<String> attendees;

  const _FortuneWheelSpeakerSelection({
    Key key,
    @required this.attendees,
    @required this.selected,
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
          animateFirst: true,
          selected: selected < 0 ? 0 : selected,
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
