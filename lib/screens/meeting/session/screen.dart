import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/blocs/app_bloc.dart';
import 'package:meet/models/meeting/meeting.dart';
import 'package:meet/screens/meeting/session/widgets/speaker_controls.dart';
import 'package:meet/widgets/widgets.dart';

import 'widgets/widgets.dart';

class _NoSessionMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('No session active. Please set one up.');
  }
}

class _ActiveSession extends HookWidget {
  final MeetingSession session;

  const _ActiveSession({
    Key key,
    @required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeSpeaker = useState(0);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpeakerControls(
              selected: activeSpeaker.value,
              onChanged: (value) => activeSpeaker.value = value,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 512,
                maxHeight: 512,
              ),
              child: SizedBox.expand(
                child: SpeakerView(
                  selected: activeSpeaker.value,
                  speakers: session.event.attendees,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingSessionScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('MeetingSessionPage'),
      child: MeetingSessionScreen(),
    );
  }

  const MeetingSessionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) =>
          previous.meetingSession != current.meetingSession,
      builder: (context, state) {
        return AppLayout(
          builder: (context) {
            return state.meetingSession == null
                ? _NoSessionMessage()
                : _ActiveSession(session: state.meetingSession);
          },
        );
      },
    );
  }
}
