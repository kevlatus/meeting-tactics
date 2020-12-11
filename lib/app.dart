import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/screens/meeting/meeting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'auth/auth.dart';
import 'constants.dart';
import 'routes.dart';
import 'theme.dart';

class MeetApp extends StatefulWidget {
  final AuthRepository authRepository;
  final CalendarRepository calendarRepository;

  MeetApp({
    Key key,
    @required this.authRepository,
    @required this.calendarRepository,
  })  : assert(authRepository != null),
        super(key: key);

  @override
  _MeetAppState createState() => _MeetAppState();
}

class _MeetAppState extends State<MeetApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.authRepository),
        RepositoryProvider.value(value: widget.calendarRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(authRepository: widget.authRepository),
          ),
          BlocProvider(
            create: (_) => MeetingSessionCubit(),
          ),
        ],
        child: MaterialApp(
          title: kAppName,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateRoute: AppRouter.generator,
          theme: ThemeData(
            visualDensity: VisualDensity.standard,
            primarySwatch: KevlatusColors.mint,
            primaryColor: KevlatusColors.mint,
            accentColor: KevlatusColors.purple,
          ),
          darkTheme: ThemeData(
            visualDensity: VisualDensity.standard,
            primarySwatch: KevlatusColors.mintForDark,
            primaryColor: KevlatusColors.mintForDark,
            accentColor: KevlatusColors.purpleAccent,
            brightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}
