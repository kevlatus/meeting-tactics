import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

enum SpeakerViewType {
  List,
  FortuneWheel,
}

class SpeakerView extends StatelessWidget {
  final SpeakerViewType type;
  final List<EventGuest> speakers;
  final int selected;

  Widget _buildList(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyText2;

    return ListView.builder(
      itemCount: speakers.length,
      itemBuilder: (context, index) {
        final style = selected == index
            ? theme.copyWith(fontWeight: FontWeight.bold)
            : theme;

        return ListTile(
          title: Text(
            speakers[index].email,
            style: style,
          ),
        );
      },
    );
  }

  Widget _buildFortuneWheel(BuildContext context) {
    return FortuneWheel(
      selected: selected,
      slices: speakers
          .map(
            (e) => CircleSlice(child: Text(e.name)),
          )
          .toList(),
    );
  }

  const SpeakerView({
    Key key,
    this.type = SpeakerViewType.FortuneWheel,
    @required this.speakers,
    this.selected = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SpeakerViewType.List:
        return _buildList(context);
      case SpeakerViewType.FortuneWheel:
        return _buildFortuneWheel(context);
    }

    throw 'wat';
  }
}
