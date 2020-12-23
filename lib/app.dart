import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/screens/meeting/meeting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';
import 'routes.dart';
import 'theme.dart';

class MeetApp extends StatefulWidget {
  MeetApp({
    Key key,
  }) : super(key: key);

  @override
  _MeetAppState createState() => _MeetAppState();
}

class _MeetAppState extends State<MeetApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MeetingSessionCubit(),
        ),
      ],
      child: ThemeModeProvider(
        builder: (context, themeMode) {
          return MaterialApp(
            title: kAppName,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateRoute: AppRouter.generator,
            themeMode: themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
