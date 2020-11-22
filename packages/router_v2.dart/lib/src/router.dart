import 'package:flutter/widgets.dart';
import 'package:router_v2/router_v2.dart';
import 'package:router_v2/src/internal/route_defs.dart';

import 'models.dart';

class RouterConfig {
  final List<RouteDef> _routes;
  final RouteDef _fallbackRoute;

  RouterConfig({
    @required List<RouteDef> routes,
    @required String fallbackPath,
  })  : assert(routes != null && routes.length > 0),
        assert(
          fallbackPath != null &&
              routes.map((it) => it.path).contains(fallbackPath),
        ),
        _fallbackRoute = routes.firstWhere((it) => it.path == fallbackPath),
        _routes = routes;

  RouteDef _handleRedirects(RouteDef routeDef) {
    while (routeDef is Redirect) {
      routeDef = _routes.firstWhere(
        (it) => it.pathTemplate.matches((routeDef as Redirect).redirectTo),
      );
    }
    return routeDef;
  }

  AppRoute findByPath(String path) {
    RouteDef routeDef = _routes.firstWhere(
      (it) => it.pathTemplate.matches(path),
      orElse: () => _fallbackRoute,
    );
    routeDef = _handleRedirects(routeDef);

    final params = routeDef.pathTemplate.getRouteParams(path);
    return AppRoute(
      page: (routeDef as SimplePageRoute).builder(params),
      path: routeDef.pathTemplate.buildPath(params),
      params: params,
    );
  }

  AppRoute findByDef(RouteDef routeDef, [Map<String, String> params]) {
    if (!_routes.contains(routeDef)) {
      throw ArgumentError(
          'The given routeDef does not exist in this RouterConfig.');
    }
    routeDef = _handleRedirects(routeDef);

    return AppRoute(
      page: (routeDef as SimplePageRoute).builder(params),
      path: routeDef.pathTemplate.buildPath(params),
      params: params,
    );
  }
}
