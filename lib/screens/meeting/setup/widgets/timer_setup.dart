import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/callbacks.dart';
import 'package:meet/models/core/core.dart';
import 'package:meet/screens/meeting/setup/widgets/step_layout.dart';
import 'package:meet/widgets/widgets.dart';

import '../bloc.dart';

class TimerStrategySelector extends StatelessWidget {
  final TimerStrategy selected;
  final Callback<TimerStrategy> onChanged;

  const TimerStrategySelector({
    Key key,
    this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTextToggleButtons<TimerStrategy>(
      selected: selected,
      matcher: (v) => v.runtimeType == selected.runtimeType,
      items: [
        IconTextToggleButton(
          icon: Icon(Icons.cancel),
          text: 'None',
          value: NoTimerStrategy(),
        ),
        IconTextToggleButton(
          icon: Icon(Icons.linear_scale),
          text: 'Fixed',
          value: FixedTimerStrategy.single(duration: Duration()),
        ),
        IconTextToggleButton(
          icon: Icon(Icons.shuffle),
          text: 'Random',
          value: RandomTimerStrategy(min: Duration(), max: Duration()),
        ),
      ],
      onChanged: onChanged,
    );
  }
}

class TimerSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingSetupCubit, MeetingSetupState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        return StepLayout(
          image: Image.asset('assets/images/ic-time-management.png'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Timer Setup',
                  style: theme.textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: TimerStrategySelector(
                    selected: state.timerStrategy,
                    onChanged: (value) {
                      context
                          .bloc<MeetingSetupCubit>()
                          .changeTimerStrategy(value);
                    },
                  ),
                ),
              ),
              Center(child: StepperActions()),
            ],
          ),
        );
      },
    );
  }
}
