import 'package:auto_route/auto_route.dart';
import 'package:meet/screens/screens.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    MaterialRoute(page: HomeScreen, initial: true),
    MaterialRoute(page: SettingsScreen, path: '/settings'),
    MaterialRoute(page: MeetingSetupScreen, path: '/meeting/setup'),
    MaterialRoute(page: MeetingSessionScreen, path: '/meeting/session'),
  ],
)
class $AppRouter {}
