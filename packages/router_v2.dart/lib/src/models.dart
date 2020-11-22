import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:quiver/core.dart';
import 'package:router_v2/src/internal/path_matching.dart';

import 'internal/route_defs.dart';

typedef PageBuilder = Page Function(Map<String, String>);

enum RoutePathMatch {
  Prefix,
  Exact,
}

abstract class RouteDef {
  String get path;
  RoutePathMatch get pathMatch;
  UriPathPattern get pathTemplate;

  factory RouteDef({
    String path,
    RoutePathMatch pathMatch = RoutePathMatch.Prefix,
    PageBuilder builder,
  }) {
    return SimplePageRoute(
      builder: builder,
      path: path,
      pathMatch: pathMatch,
    );
  }

  factory RouteDef.redirect({
    String path,
    RoutePathMatch pathMatch,
    String redirectTo,
  }) {
    return Redirect(
      path: path,
      pathMatch: pathMatch,
      redirectTo: redirectTo,
    );
  }
}

class AppRoute {
  final Page page;
  final Map<String, String> params;
  final String path;

  const AppRoute({
    @required this.page,
    @required this.path,
    this.params = const <String, String>{},
  })  : assert(page != null),
        assert(path != null),
        assert(params != null);

  @override
  int get hashCode => hash3(page.hashCode, params.hashCode, path.hashCode);

  @override
  bool operator ==(Object other) =>
      other is AppRoute &&
      mapEquals(params, other.params) &&
      path == other.path;
}
