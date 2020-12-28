import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/routes.dart';
import 'package:meet/screens/meeting/meeting.dart';
import 'package:meet/timer/timer.dart';
import 'package:meet/widgets/widgets.dart';

import 'widgets/widgets.dart';

class _MeetingNotInitialized extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('No session active. Please set one up.');
  }
}

class _ActiveMeeting extends HookWidget {
  final MeetingSessionState session;

  _ActiveMeeting({
    Key key,
    @required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAnimating = useState(false);
    final controller = useCountdownController();

    useValueChanged(session.speakerIndex, (_, __) {
      controller.stop();
    });

    return Column(
      children: [
        SpeakerControls(disabled: isAnimating.value),
        if (session.speakerIndex == null)
          Expanded(child: Text('Thinking Face'))
        else
          Expanded(
            child: WheelSpeakerView(
              attendees: session.meeting.attendees,
              unavailableAttendees: session.previousSpeakers,
              direction: session.direction,
              selected: session.speakerIndex,
              onAnimationStart: () {
                isAnimating.value = true;
              },
              onAnimationEnd: () {
                isAnimating.value = false;

                if (session.direction == StepperDirection.Forward) {
                  controller.start(
                    session.timer.getTimer(session.speakerIndex),
                  );
                }
              },
            ),
          ),
        if (session.timer != null && !(session.timer is NoTimerStrategy))
          CountdownBar(controller: controller),
      ],
    );
  }
}

class MeetingSessionScreen extends StatelessWidget {
  const MeetingSessionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeetingSessionCubit, MeetingSessionState>(
      listenWhen: (_, current) => current.isFinished,
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.root,
          (route) => false,
        );
      },
      builder: (context, state) {
        return AppLayout(
          builder: (context) {
            return state.meeting == null
                ? _MeetingNotInitialized()
                : _ActiveMeeting(session: state);
          },
        );
      },
    );
  }
}
