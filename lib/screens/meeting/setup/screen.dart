import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/blocs/app_bloc.dart';
import 'package:meet/models/meeting/meeting.dart';
import 'package:meet/widgets/widgets.dart';
import 'package:router_v2/router_v2.dart';

import 'bloc.dart';
import 'widgets/widgets.dart';

class MeetingSetupScreen extends StatefulWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('MeetingSetupPage'),
      child: const MeetingSetupScreen(),
    );
  }

  const MeetingSetupScreen({Key key}) : super(key: key);

  @override
  _MeetingSetupScreenState createState() => _MeetingSetupScreenState();
}

class _MeetingSetupScreenState extends State<MeetingSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MeetingSetupBloc(),
      child: AppLayout(builder: (context) {
        return SetupStepper(
          onCompleted: () {
            final event = context.bloc<MeetingSetupBloc>().state.calendarEvent;
            context.bloc<AppBloc>().setActiveSession(
                  MeetingSession(event: event),
                );
            Router.of(context).push('/meeting/session');
          },
        );
      }),
    );
  }
}
