import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meet/router.gr.dart';
import 'package:meet/screens/screens.dart';
import 'package:meet/settings/settings.dart';

import 'constants.dart';
import 'theme.dart';

class MeetApp extends StatefulWidget {
  MeetApp({
    Key key,
  }) : super(key: key);

  @override
  _MeetAppState createState() => _MeetAppState();
}

class _MeetAppState extends State<MeetApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => SettingsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => MeetingSessionCubit(),
          ),
        ],
        child: ThemeModeProvider(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: kAppName,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerDelegate: _router.delegate(),
              routeInformationParser: _router.defaultRouteParser(),
              themeMode: themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
            );
          },
        ),
      ),
    );
  }
}
