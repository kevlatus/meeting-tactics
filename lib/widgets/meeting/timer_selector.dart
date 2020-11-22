import 'package:flutter/material.dart';
import 'package:meet/models/models.dart';

import 'callbacks.dart';

class TimerSelector extends StatelessWidget {
  final SpeakerTimerCallback onChanged;
  final List<SpeakerTimer> types;
  final SpeakerTimer value;

  const TimerSelector({
    Key key,
    @required this.types,
    @required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text('Timer Type'),
      isExpanded: true,
      value: value?.label,
      items: types.map((timerType) {
        return DropdownMenuItem(
          value: timerType.label,
          child: Text(timerType.label),
        );
      }).toList(),
      onChanged: (label) {
        onChanged(types.firstWhere((element) => element.label == label));
      },
    );
  }
}
