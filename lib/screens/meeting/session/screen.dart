import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/router.gr.dart';
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

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgOrPngImage('assets/images/img-undraw-meeting.png');
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
    final ticker = useSingleTickerProvider();
    final controller = useCountdownController();

    useValueChanged(session.speakerIndex, (_, __) {
      controller.stop();
    });

    return Column(
      children: [
        SizedBox(height: 8),
        SpeakerControls(disabled: isAnimating.value),
        if (session.speakerIndex == null)
          Expanded(child: LobbyScreen())
        else
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: session.meeting.attendees.length < 4
                  ? WheelSpeakerView(
                      attendees: session.meeting.attendees,
                      unavailableAttendees: session.previousSpeakers,
                      direction: session.direction,
                      selected: session.speakerIndex,
                      onAnimationStart: () {
                        isAnimating.value = true;
                      },
                      onAnimationEnd: () {
                        isAnimating.value = false;

                        if (session.direction == StepperDirection.Forward &&
                            !(session.timer is NoTimerStrategy)) {
                          controller.start(
                            session.timer.getTimer(session.speakerIndex),
                          );
                        }
                      },
                    )
                  : BarSpeakerView(
                      attendees: session.meeting.attendees,
                      unavailableAttendees: session.previousSpeakers,
                      direction: session.direction,
                      selected: session.speakerIndex,
                      onAnimationStart: () {
                        isAnimating.value = true;
                      },
                      onAnimationEnd: () {
                        isAnimating.value = false;

                        if (session.direction == StepperDirection.Forward &&
                            !(session.timer is NoTimerStrategy)) {
                          controller.start(
                            session.timer.getTimer(session.speakerIndex),
                          );
                        }
                      },
                    ),
            ),
          ),
        if (session.timer != null && !(session.timer is NoTimerStrategy))
          AnimatedSize(
            vsync: ticker,
            duration: Duration(milliseconds: 300),
            child: CountdownBar(controller: controller),
          ),
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
        AutoRouter.of(context).pushAndRemoveUntil(
          HomeRoute(),
          predicate: (route) => false,
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
