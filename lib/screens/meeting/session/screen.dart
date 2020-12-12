import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/routes.dart';
import 'package:meet/screens/meeting/meeting.dart';
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

  const _ActiveMeeting({
    Key key,
    @required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAnimating = useState(false);

    final unavailableAttendees = session.selectedSpeakers.take(
      session.selectedSpeakers.isEmpty
          ? 0
          : session.selectedSpeakers.length - 1,
    ).toList();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpeakerControls(disabled: isAnimating.value),
            SpeakerSelectionView(
              attendees: session.meeting.attendees,
              unavailableAttendees: unavailableAttendees,
              selected: session.selectedSpeakerIndex,
              onAnimationStart: () {
                isAnimating.value = true;
              },
              onAnimationEnd: () {
                isAnimating.value = false;
              },
            ),
          ],
        ),
      ),
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
