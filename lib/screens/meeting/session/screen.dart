import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/blocs/app_bloc.dart';
import 'package:meet/models/meeting/meeting.dart';
import 'package:meet/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'widgets/widgets.dart';

class _NoSessionMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('No session active. Please set one up.');
  }
}

class SpeakerControls extends StatelessWidget {
  const SpeakerControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderStrategy = Provider.of<OrderStrategy>(context);

    if (!orderStrategy.isStarted) {
      return FlatButton.icon(
        icon: Icon(Icons.play_arrow),
        label: Text('START'),
        onPressed: orderStrategy.next,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text('NEXT'),
          onPressed: orderStrategy.next,
        ),
        FlatButton.icon(
          icon: Icon(Icons.fast_rewind),
          label: Text('UNDO'),
          onPressed: orderStrategy.isStarted ? orderStrategy.previous : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.skip_previous),
          label: Text('RESTART'),
          onPressed: orderStrategy.isStarted ? orderStrategy.reset : null,
        ),
      ],
    );
  }
}

class _SelectionVisualizer<T> extends StatelessWidget {
  final List<EventGuest> attendees;

  const _SelectionVisualizer({
    Key key,
    @required this.attendees,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderStrategy = Provider.of<OrderStrategy>(context);
    if (!orderStrategy.isStarted) {
      return Container();
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 512,
        maxHeight: 512,
      ),
      child: SizedBox.expand(
        child: SpeakerView(
          selected: orderStrategy.selected,
          speakers: attendees,
        ),
      ),
    );
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
    return ChangeNotifierProvider<OrderStrategy>(
      create: (_) => FixedOrderStrategy(session.event.attendees.length),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpeakerControls(),
              _SelectionVisualizer(attendees: session.event.attendees),
            ],
          ),
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
