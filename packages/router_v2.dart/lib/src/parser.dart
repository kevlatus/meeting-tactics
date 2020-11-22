import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'models.dart';
import 'router.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  final RouterConfig _routerConfig;

  AppRouteInformationParser(this._routerConfig) : assert(_routerConfig != null);

  @override
  Future<AppRoute> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location);
    final route = _routerConfig.findByPath(uri.path);
    return SynchronousFuture(route);
  }

  @override
  RouteInformation restoreRouteInformation(AppRoute route) {
    return RouteInformation(location: route.path);
  }
}
