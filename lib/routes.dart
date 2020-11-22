import 'package:meet/auth/auth.dart';
import 'package:meet/screens/screens.dart';
import 'package:router_v2/router_v2.dart';

final routerConfig = RouterConfig(
  routes: [
    RouteDef(
      path: '/',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => HomeScreen.page(),
    ),
    RouteDef(
      path: '/meeting/session',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => MeetingSessionScreen.page(),
    ),
    RouteDef(
      path: '/meeting/setup',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => MeetingSetupScreen.page(),
    ),
    RouteDef(
      path: '/tactics',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => TacticsScreen.page(),
    ),
    RouteDef(
      path: '/tactics/:id',
      pathMatch: RoutePathMatch.Exact,
      builder: (params) => TacticsDetailScreen.page(params['id']),
    ),
    RouteDef(
      path: '/settings',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => SettingsScreen.page(),
    ),
    RouteDef(
      path: '/legal',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => LegalNoticeScreen.page(),
    ),
    RouteDef.redirect(
        path: '/impressum',
        pathMatch: RoutePathMatch.Exact,
        redirectTo: '/legal'),
    RouteDef(
      path: '/privacy',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => PrivacyPolicyScreen.page(),
    ),
    RouteDef(
      path: '/signin',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => LoginScreen.page(),
    ),
    RouteDef(
      path: '/404',
      pathMatch: RoutePathMatch.Exact,
      builder: (_) => UnknownScreen.page(),
    ),
  ],
  fallbackPath: '/404',
);
