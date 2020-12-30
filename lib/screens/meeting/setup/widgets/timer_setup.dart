import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/screens/meeting/setup/widgets/step_layout.dart';
import 'package:meet/timer/timer.dart';
import 'package:meet/widgets/widgets.dart';

import '../bloc.dart';

class TimerSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingSetupCubit, MeetingSetupState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        void handleStrategyChange(TimerStrategy strategy) {
          context.bloc<MeetingSetupCubit>().changeTimerStrategy(strategy);
        }

        return StepLayout(
          image: SvgOrPngImage('assets/images/img-undraw-time-management.png'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How much time do I have?',
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 16),
              Text('Choose a speaking time limit per participant.'),
              SizedBox(height: 16),
              Center(
                child: TimerStrategySelector(
                  selected: state.timerStrategy,
                  onChanged: handleStrategyChange,
                ),
              ),
              SizedBox(height: 16),
              if (state.timerStrategy is FixedTimerStrategy)
                FixedTimerSelector(
                  strategy: state.timerStrategy,
                  onChanged: handleStrategyChange,
                ),
              if (state.timerStrategy is RandomTimerStrategy)
                RandomTimerSelector(
                  strategy: state.timerStrategy,
                  onChanged: handleStrategyChange,
                ),
              SizedBox(height: 8),
              Center(child: StepperActions()),
            ],
          ),
        );
      },
    );
  }
}
