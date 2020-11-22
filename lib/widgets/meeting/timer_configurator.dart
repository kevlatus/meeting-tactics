import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:meet/models/models.dart';
import 'package:meet/widgets/meeting/meeting.dart';

import 'callbacks.dart';
import 'timer_selector.dart';

class TimerConfigurator extends StatelessWidget {
  final SpeakerTimerCallback onChanged;
  final SpeakerTimer value;

  Widget _buildOptions(BuildContext context) {
    if (value is RandomDurationTimer) {
      return RandomDurationSelector();
    }

    if (value is FixedDurationTimer) {
      return DurationPicker(
        duration: value.options,
        onChange: (v) {
          if (onChanged != null) {
            onChanged(value.copyWith(options: v));
          }
        },
      );
    }

    return Container();
  }

  const TimerConfigurator({
    Key key,
    this.value = const NoTimer(),
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Speaker Timer',
          style: theme.textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        TimerSelector(
          value: value,
          types: [
            NoTimer(),
            FixedDurationTimer(),
//          RandomDurationTimer(),
          ],
          onChanged: (v) {
            if (onChanged != null) {
              onChanged(v);
            }
          },
        ),
        _buildOptions(context),
      ],
    );
  }
}
